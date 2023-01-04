import 'dart:convert';
import 'package:budi/AgentSection/AgentsNearby.dart';
import 'package:budi/AgentSection/AgentsProfile.dart';
import 'package:budi/BottomNavigationScreens/SearchPage.dart';
import 'package:budi/Common%20Fields/AppDailogBox.dart';
import 'package:budi/Common%20Fields/AppTextField.dart';
import 'package:budi/Common%20Fields/CircularIndicator.dart';
import 'package:budi/HomePageItems/Hotels.dart';
import 'package:budi/HomePageItems/RentCar.dart';
import 'package:budi/HomePageItems/TravelInsurance.dart';
import 'package:budi/Models/FeaturedAgentsModel.dart';
import 'package:budi/Models/OffersModel.dart';
import 'package:budi/Models/UserInfoModel.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  UserInfoModel? userInfoModel;

  HomePage({Key? key, this.userInfoModel}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  List<String> travelOptions = ['Hotels', 'Car Rentals', 'Travel insurance'];
  String? _currentAddress;
  Position? _currentPosition;
  FeaturedAgentsModel? featuredAgents;
  OffersModel? offersModel;
  User? userDetail;



  getOffers() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('LogInToken');
      var userId = sharedPreferences.getString('UserId');
      final res = await http
          .get(Uri.parse("http://74.208.150.111/api/offers"), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      final int statusCode = res.statusCode;
      if (statusCode == 200) {
        Map<String, dynamic> decoded = json.decode(res.body);
        OffersModel data = OffersModel.fromJson(decoded);
        offersModel = data;
        setState(() {});
      } else {
        print(statusCode);
      }
    } catch (exception) {
      print("Please Check Internet");
    }
  }

  getFeaturedAgents() async {
    try {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('LogInToken');
      var userId = sharedPreferences.getString('UserId');
      final res = await http
          .get(Uri.parse("http://74.208.150.111/api/users/featured_agents"), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      final int statusCode = res.statusCode;
      if (statusCode == 200) {
        Map<String, dynamic> decoded = json.decode(res.body);
        FeaturedAgentsModel data = FeaturedAgentsModel.fromJson(decoded);
        featuredAgents = data;
        setState(() {});
      } else {
        print(statusCode);
      }
    } catch (exception) {
      print("Please Check Internet");
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
      print(_currentPosition?.latitude ?? "");
      print(_currentPosition?.longitude ?? "");
      sendCoOrdinates(_currentPosition!.latitude.toString(),
          _currentPosition!.longitude.toString());
    }).catchError((e) {
      debugPrint(e);
    });
  }

  sendCoOrdinates(String latitude, String longitude) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('LogInToken');
      var params = {
        "latitude": latitude,
        "longitude": longitude,
      };
      final url = Uri.parse('http://74.208.150.111/api/coordinates/update');
      var request = http.MultipartRequest('POST', url)..fields.addAll(params);
      request.headers.addAll({
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      });
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      var encoded = json.decode(respStr);
      final int statusCode = url.port;
      if (response.statusCode == 200) {
        // userInfoModel = data;
        // SharedPreferenceManager.getInstance.updateUserDetails(userInfoModel!);
        setState(() {});
      } else {
        print(statusCode);
      }
    } catch (exception) {
      print("Please Check Internet");
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> getProfileDetails() async {
    try {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('LogInToken');
      final res = await http
          .get(Uri.parse("http://74.208.150.111/api/user"), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      final int statusCode = res.statusCode;
      if (statusCode == 200) {
        Map<String, dynamic> decoded = json.decode(res.body);
        User data = User.fromJson(decoded);
        userDetail = data;
        setState(() {});
      } else {
        print(statusCode);
      }
    } catch (exception) {
      print("Please Check Internet");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getFeaturedAgents();
    getProfileDetails();
    getCurrentPosition();
    getOffers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.OFF_WHITE_COLOR,
      body: userDetail != null || featuredAgents != null || offersModel != null?SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width / 1.7,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            Assets.icHomeBackground,
                          ),
                          fit: BoxFit.fill)),
                ),
                Positioned(
                  top: 35,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textView('Good morning ${userDetail?.name ?? ''},', 20,
                                AppColor.SIGNIN_COLOR),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Lets plan your next trip \n now!)',
                              style: TextStyle(
                                  color: AppColor.SIGNIN_COLOR,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(userDetail?.profile?.profilePicture ?? ''),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SearchPage(isHome: true)));
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: AppTextField(
                          prefixIcon: Assets.ic_Search,
                          hintText: 'Search',
                          enable: false,
                          obscureText: false,
                          isSearch: true,
                          controller: searchController,
                        ),
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: travelOptions.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 10),
                            alignment: Alignment.center,
                            height: 39,
                            width: 133,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(48),
                                color: Colors.white),
                            child: Text(
                              travelOptions[index],
                              style: const TextStyle(
                                  color: AppColor.HOMETEXT, fontSize: 16),
                            )),
                      ],
                    );
                  }),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AgentsNearBy(
                            latitide: _currentPosition?.latitude.toString(),
                            longitude:
                                _currentPosition?.longitude.toString())));
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColor.DARKBLUE,
                ),
                height: MediaQuery.of(context).size.width / 3,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textView('Agents nearby', 20, Colors.white),
                        const SizedBox(
                          height: 13,
                        ),
                        textView('Request services (Transport, Hotels etc.)',
                            10, Colors.white),
                        const SizedBox(
                          height: 20,
                        ),
                        textView('Show on map', 12, Colors.white),
                      ],
                    ),
                    Image.asset(
                      Assets.icPersonPin,
                      height: 60,
                      width: 50,
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 280,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textView('Featured agents', 20, AppColor.SIGNIN_COLOR),
                      textView('See all', 14, AppColor.DARKBLUE),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 225,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: featuredAgents?.agents?.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AgentsProfilePage(
                                              user: featuredAgents?.agents?[index])));
                            },
                            child: Container(
                              width: 163,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Card(
                                elevation: 3,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              Colors.greenAccent[400],
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                              featuredAgents?.agents?[index].profile?.profilePicture ?? ''),
                                        ),
                                        Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Image.asset(
                                              Assets.icVerified,
                                              height: 16,
                                              width: 16,
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    textView(
                                        featuredAgents?.agents?[index].name ?? '', 16, AppColor.HOMETEXT),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    textView(
                                        '14 projects', 12, AppColor.TEXT_COLOR),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        starIcon(Icons.star, 12),
                                        starIcon(Icons.star, 12),
                                        starIcon(Icons.star, 12),
                                        starIcon(Icons.star, 12),
                                        starIcon(Icons.star, 12),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    textView(
                                        'At vero eos et \n accusamus et iusto \n odio',
                                        12,
                                        AppColor.HOMETEXT)
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              height: (MediaQuery.of(context).size.width * 0.8) / 1.6,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        offerDialogue(context, onTap: () {});
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(15)),
                        child: Card(
                          elevation: 3,
                          child: Image.asset(
                            Assets.icofferDemo,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            cardView(Assets.icHotels, 'Hotels',
                'Let us help you choose the accommodation\n that best suits you.',
                () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const Hotels()));
            }),
            cardView(Assets.icDirectionCars, 'Rent a car',
                'Rent a car of your choice without the hassle', () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const RentCar()));
            }),
            cardView(Assets.icHealthSafety, 'Travel insurance',
                'Get easy and affordable Travel\n insurance within minutes!',
                () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const TravelInsurance()));
            }),
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textView('Offers', 20, AppColor.SIGNIN_COLOR),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      textView('All', 14, AppColor.DARKBLUE),
                      const SizedBox(
                        width: 8,
                      ),
                      textView('Recommended', 14, AppColor.DARKBLUE),
                      const SizedBox(
                        width: 8,
                      ),
                      textView('Popular', 14, AppColor.DARKBLUE),
                      const SizedBox(
                        width: 8,
                      ),
                      textView('trending', 14, AppColor.DARKBLUE),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 190,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            // decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(15)),
                            child: Card(
                              elevation: 3,
                              child: Stack(
                                children: [
                                  Image.asset(
                                    Assets.icDemoTwo,
                                    fit: BoxFit.fill,
                                    width: 330,
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      child: Container(
                                        height: 80,
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 30),
                                        width:
                                            MediaQuery.of(context).size.width -
                                                80,
                                        color: AppColor.SIGNIN_COLOR
                                            .withOpacity(0.4),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                textView('Awesome trip', 16,
                                                    Colors.white),
                                                Row(
                                                  children: [
                                                    textView(
                                                        'Sed ut perspiciatis ',
                                                        14,
                                                        Colors.white),
                                                    Image.asset(
                                                      Assets.icVerified,
                                                      height: 14,
                                                      width: 14,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                starIcon(Icons.star, 22),
                                                textView(
                                                    '4.8', 18, Colors.white),
                                              ],
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ): circularIndicator(context),
    );
  }

  textView(String lable, double fontSize, Color colors) {
    return getRegularStyleText(
      msg: lable,
      color: colors,
      fontSize: fontSize,
      textAlign: TextAlign.center,
    );
  }

  cardView(
      String image, String travelOption, String descText, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(15)),
        child: Card(
          elevation: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 100,
                alignment: Alignment.center,
                child: Image.asset(
                  image,
                  height: 60,
                  width: 50,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  textView(travelOption, 20, AppColor.SIGNIN_COLOR),
                  const SizedBox(
                    height: 10,
                  ),
                  textView(descText, 10, AppColor.SIGNIN_COLOR),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  starIcon(IconData star, double size) {
    return Icon(
      Icons.star,
      color: Colors.amber,
      size: size,
    );
  }
}
