import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/Common%20Fields/AppDailogBox.dart';
import 'package:budi/HomePageItems/HotelCheckOut.dart';
import 'package:budi/TabBar/HotelFeatures.dart';
import 'package:budi/TabBar/HotelReviews.dart';
import 'package:budi/TabBar/HotelTabDetails.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class HotelsDetailPage extends StatefulWidget {
  const HotelsDetailPage({Key? key}) : super(key: key);

  @override
  State<HotelsDetailPage> createState() => _HotelsDetailPageState();
}

class _HotelsDetailPageState extends State<HotelsDetailPage> {
  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: AppButton(
            width: MediaQuery.of(context).size.width,
            height: 55,
            color: AppColor.BUTTON_COLOR,
            label: 'Book Now',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HotelCheckOut()));
            },
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              size: 25,
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          backgroundColor: AppColor.BUTTON_COLOR,
          title: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 1.5,
              child: getSemiBoldText(
                msg: 'Renaissance Motel',
                color: Colors.white,
                fontSize: 16,
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Column(
              children: [
                Image.asset('assets/images/ic_hotelDetail.png'),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getSemiBoldText(
                        msg: 'Selina Bogota Hotel',
                        fontSize: 16,
                        color: AppColor.SIGNIN_COLOR),
                    SizedBox(
                      width: 8,
                    ),
                    Image.asset(
                      'assets/images/ic_bookmark.png',
                      height: 13,
                      width: 13,
                    )
                  ],
                ),
                SizedBox(
                  height: 7,
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
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textView('150', 14, AppColor.BUTTON_COLOR),
                    textView('/Night', 14, AppColor.TEXT_COLOR)
                  ],
                ),
                ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width,
                      minHeight: 0,
                      maxHeight: 502,
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              6,
                                          child: Tab(
                                            text: 'Details',
                                          )),
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              6,
                                          child: Tab(text: 'Features')),
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              6,
                                          child: Tab(text: 'Reviews')),
                                    ])),
                            Expanded(
                                child: TabBarView(
                              controller: _tabController,
                              children: [
                                HotelTabDetails(),
                                HotelFeatures(),
                                HotelReviews()
                              ],
                            )),
                          ],
                        )))
              ],
            ),
          ),
        ));
  }
}
