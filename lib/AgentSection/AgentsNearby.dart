import 'dart:convert';
import 'package:budi/Common%20Fields/CircularIndicator.dart';
import 'package:budi/Helpers/AppIndicator.dart';
import 'package:budi/Map/SimpleMap.dart';
import 'package:budi/Models/NearByAgentsModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:budi/AgentSection/AgentsProfile.dart';
import 'package:budi/Common%20Fields/AppDailogBox.dart';
import 'package:budi/Common%20Fields/AppTextField.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgentsNearBy extends StatefulWidget {
  String? latitide;
  String? longitude;

  AgentsNearBy({Key? key, this.longitude, this.latitide}) : super(key: key);

  @override
  State<AgentsNearBy> createState() => _AgentsNearByState();
}

class _AgentsNearByState extends State<AgentsNearBy> {
  TextEditingController searchController = TextEditingController();
  NearbyAgentsModel? nearbyAgentsModel;

  agentsNearby(String latitide, String longitude) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('LogInToken');
      final res = await http.get(
          Uri.parse(
              "http://74.208.150.111/api/coordinates/nearby_agents?latitude=28.6344814&longitude=77.3533416"),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          });
      final int statusCode = res.statusCode;
      if (statusCode == 200) {
        Map<String, dynamic> decoded = json.decode(res.body);
        NearbyAgentsModel data = NearbyAgentsModel.fromJson(decoded);
        nearbyAgentsModel = data;
        setState(() {});
      } else {
        print(statusCode);
      }
    } catch (exception) {
      AppIndicator.disposeIndicator();
      print("Please Check Internet");
    }
  }

  @override
  void initState() {
    agentsNearby(widget.latitide ?? '', widget.longitude ?? '');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.OFF_WHITE_COLOR,
        body: nearbyAgentsModel != null
            ? SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      AppTextField(
                        prefixIcon: Assets.ic_Search,
                        hintText: 'Search',
                        obscureText: false,
                        enable: true,
                        isSearch: true,
                        controller: searchController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                        height: 250,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: SimpleMap()),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: textView(
                            '${nearbyAgentsModel?.users?.length} Agents in your Area',
                            20,
                            AppColor.SIGNIN_COLOR),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        height: 225,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: nearbyAgentsModel?.users?.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AgentsProfilePage(
                                                  user: nearbyAgentsModel?.users?[index])));
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
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        textView(
                                            nearbyAgentsModel
                                                    ?.users?[index].name ??
                                                '',
                                            16,
                                            AppColor.HOMETEXT),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        textView('14 projects', 12,
                                            AppColor.TEXT_COLOR),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            nearbyAgentsModel?.users?[index].averageRating == 1 ?starIcon(Icons.star, 12):SizedBox(),
                                            nearbyAgentsModel?.users?[index].averageRating == 2 ?starIcon(Icons.star, 12):SizedBox(),
                                            nearbyAgentsModel?.users?[index].averageRating == 3 ?starIcon(Icons.star, 12):SizedBox(),
                                            nearbyAgentsModel?.users?[index].averageRating == 4 ?starIcon(Icons.star, 12):SizedBox(),
                                            nearbyAgentsModel?.users?[index].averageRating == 5 ?starIcon(Icons.star, 12):SizedBox(),
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
                    ]),
              )
            : circularIndicator(context));
  }
}
