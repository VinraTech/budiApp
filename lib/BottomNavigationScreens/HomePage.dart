import 'package:budi/AgentSection/AgentsNearby.dart';
import 'package:budi/BottomNavigationScreens/SearchPage.dart';
import 'package:budi/Common%20Fields/AppDailogBox.dart';
import 'package:budi/Common%20Fields/AppTextField.dart';
import 'package:budi/HomePageItems/Hotels.dart';
import 'package:budi/HomePageItems/RentCar.dart';
import 'package:budi/HomePageItems/TravelInsurance.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  List<String> travelOptions = ['Hotels', 'Car Rentals', 'Travel insurance'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.OFF_WHITE_COLOR,
      body: SingleChildScrollView(
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
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textView('Good morning Mr Peterson,', 20,
                                AppColor.SIGNIN_COLOR),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
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
                          child: Image.asset('assets/images/Image.png'), //Text
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
                            MaterialPageRoute(builder: (context) => SearchPage(isHome: true)));
                      },
                      child: Container(
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
            SizedBox(
              height: 10,
            ),
            Container(
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
                            margin: EdgeInsets.only(left: 10),
                            alignment: Alignment.center,
                            height: 39,
                            width: 133,
                            child: Text(
                              travelOptions[index],
                              style: TextStyle(
                                  color: AppColor.HOMETEXT, fontSize: 16),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(48),
                                color: Colors.white)),
                      ],
                    );
                  }),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AgentsNearBy()));
              },
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColor.DARKBLUE,
                ),
                height: MediaQuery.of(context).size.width / 3,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textView('Agents nearby', 20, Colors.white),
                        SizedBox(
                          height: 13,
                        ),
                        textView('Request services (Transport, Hotels etc.)',
                            10, Colors.white),
                        SizedBox(
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
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textView('Featured agents', 20, AppColor.SIGNIN_COLOR),
                      textView('See all', 14, AppColor.DARKBLUE),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 225,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 163,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: Card(
                              elevation: 3,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Stack(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            Colors.greenAccent[400],
                                        radius: 30,
                                        child: Image.asset(
                                            'assets/images/Image.png'), //Text
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
                                  SizedBox(
                                    height: 6,
                                  ),
                                  textView(
                                      'Alex Buckmaster', 16, AppColor.HOMETEXT),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  textView(
                                      '14 projects', 12, AppColor.TEXT_COLOR),
                                  SizedBox(
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
                                  SizedBox(
                                    height: 6,
                                  ),
                                  textView(
                                      'At vero eos et \n accusamus et iusto \n odio',
                                      12,
                                      AppColor.HOMETEXT)
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
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
                      child: Container(
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
            SizedBox(
              height: 10,
            ),
            cardView(Assets.icHotels, 'Hotels',
                'Let us help you choose the accommodation\n that best suits you.',
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Hotels()));
            }),
            cardView(Assets.icDirectionCars, 'Rent a car',
                'Rent a car of your choice without the hassle', () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RentCar()));
            }),
            cardView(Assets.icHealthSafety, 'Travel insurance',
                'Get easy and affordable Travel\n insurance within minutes!',
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TravelInsurance()));
            }),
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textView('Offers', 20, AppColor.SIGNIN_COLOR),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      textView('All', 14, AppColor.DARKBLUE),
                      SizedBox(
                        width: 8,
                      ),
                      textView('Recommended', 14, AppColor.DARKBLUE),
                      SizedBox(
                        width: 8,
                      ),
                      textView('Popular', 14, AppColor.DARKBLUE),
                      SizedBox(
                        width: 8,
                      ),
                      textView('trending', 14, AppColor.DARKBLUE),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 190,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Container(
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
                                        padding: EdgeInsets.only(
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
      ),
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
                  SizedBox(
                    height: 8,
                  ),
                  textView(travelOption, 20, AppColor.SIGNIN_COLOR),
                  SizedBox(
                    height: 10,
                  ),
                  textView(descText, 10, AppColor.SIGNIN_COLOR),
                  SizedBox(
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
