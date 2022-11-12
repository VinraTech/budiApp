import 'dart:io';

import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/Common%20Fields/AppDailogBox.dart';
import 'package:budi/TabBar/TabOffers.dart';
import 'package:budi/TabBar/TabProfile.dart';
import 'package:budi/TabBar/TabReview.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class AgentsProfilePage extends StatefulWidget {
  AgentsProfilePage({Key? key}) : super(key: key);

  @override
  State<AgentsProfilePage> createState() => _AgentsProfilePageState();
}

class _AgentsProfilePageState extends State<AgentsProfilePage> {
  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 600,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width / 2.4,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              Assets.icHomeBackground,
                            ),
                            fit: BoxFit.fill)),
                  ),
                  Positioned(
                      top: 110,
                      left: 10,
                      right: 10,
                      child: Column(
                        children: [
                          Container(
                            child: CircleAvatar(
                              backgroundColor: Colors.greenAccent[400],
                              radius: 55,
                              child:
                                  Image.asset('assets/images/Image.png'), //Text
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getSemiBoldText(
                                  msg: 'James Hall',
                                  fontSize: 30,
                                  color: AppColor.SIGNIN_COLOR),
                              Image.asset(
                                Assets.icVerified,
                                height: 16,
                                width: 16,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          getRegularStyleText(
                              msg: 'Woodland Hills, CA',
                              fontSize: 14,
                              color: AppColor.SIGNIN_COLOR),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              starIcon(Icons.star, 12),
                              starIcon(Icons.star, 12),
                              starIcon(Icons.star, 12),
                              starIcon(Icons.star, 12),
                              starIcon(Icons.star, 12),
                              getRegularStyleText(
                                  msg: '17',
                                  fontSize: 12,
                                  color: AppColor.SIGNIN_COLOR),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          getRegularStyleText(
                              msg:
                                  'Its The Bright One, Its The Right One,\n Thats Agency.',
                              fontSize: 14,
                              color: AppColor.SIGNIN_COLOR,
                              textAlign: TextAlign.center),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              boxView('17', 'projects', 20),
                              boxView('6', 'Offers', 20),
                              boxView('100+', ' completed', 20),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          AppButton(
                            width: MediaQuery.of(context).size.width,
                            height: 55,
                            color: AppColor.BUTTON_COLOR,
                            label: 'Request',
                            onTap: () {},
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          AppButton(
                            width: MediaQuery.of(context).size.width,
                            height: 55,
                            color: AppColor.OFF_WHITE_COLOR,
                            borderColor: AppColor.BUTTON_COLOR,
                            label: 'Message',
                            onTap: () {},
                            lableColor: AppColor.BUTTON_COLOR,
                          )
                        ],
                      ))
                ],
              ),
            ),
            ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                  minHeight: 0,
                  maxHeight: 600,
                ),
                child: DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        PreferredSize(
                            preferredSize: Size.fromHeight(50.0),
                            child: TabBar(
                                controller: _tabController,
                                indicatorColor: AppColor.LABLE_COLOR,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicatorWeight: 2.0,
                                unselectedLabelColor: AppColor.TEXT_COLOR,
                                labelColor: AppColor.LABLE_COLOR,
                                isScrollable: true,
                                tabs: [
                                  Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      child: Tab(
                                        text: 'Profile',
                                      )),
                                  Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      child: Tab(text: 'Reviews')),
                                  Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      child: Tab(text: 'Offers')),
                                ])),
                        Expanded(
                            child: TabBarView(
                          controller: _tabController,
                          children: [TabProfile(), TabReview(), TabOffers()],
                        )),
                      ],
                    )))
          ],
        ),
      ),
    );
  }

  boxView(String msg, String msg2, double fontSize) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.OFF_WHITE_COLOR),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getBoldText(
                  msg: msg, fontSize: fontSize, color: AppColor.SIGNIN_COLOR),
              getRegularStyleText(
                msg: msg2,
                fontSize: 14,
                color: AppColor.SIGNIN_COLOR,
              ),
            ],
          ),
        )
      ],
    );
  }
}
