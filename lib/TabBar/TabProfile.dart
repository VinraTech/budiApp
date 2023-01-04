import 'package:budi/Common%20Fields/AppDailogBox.dart';
import 'package:budi/Models/FeaturedAgentsModel.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:flutter/material.dart';

class TabProfile extends StatefulWidget {
  FeaturedAgentsModel? featuredAgents;
  TabProfile({Key? key,this.featuredAgents}) : super(key: key);

  @override
  State<TabProfile> createState() => _TabProfileState();
}

class _TabProfileState extends State<TabProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 190,
            margin: const EdgeInsets.all(15),
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
          Container(
            height: 280,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textView('Similar agents', 20, AppColor.SIGNIN_COLOR),
                    textView('See all', 14, AppColor.DARKBLUE),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 225,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.featuredAgents?.agents?.length,
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
                                        backgroundImage: NetworkImage(
                                            widget.featuredAgents?.agents?[index].profile?.profilePicture ?? ''), //Text
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
                                    widget.featuredAgents?.agents?[index].name ?? '', 16, AppColor.HOMETEXT),
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
                                    widget.featuredAgents?.agents?[index].averageRating == 1 ?starIcon(Icons.star, 12) : SizedBox(),
                                    widget.featuredAgents?.agents?[index].averageRating == 2 ?starIcon(Icons.star, 12) : SizedBox(),
                                    widget.featuredAgents?.agents?[index].averageRating == 3 ?starIcon(Icons.star, 12) : SizedBox(),
                                    widget.featuredAgents?.agents?[index].averageRating == 4 ?starIcon(Icons.star, 12) : SizedBox(),
                                    widget.featuredAgents?.agents?[index].averageRating == 5 ?starIcon(Icons.star, 12) : SizedBox(),
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
        ],
      ),
    );
  }
}
