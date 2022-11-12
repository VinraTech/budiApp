import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/Common%20Fields/AppDailogBox.dart';
import 'package:budi/HomePageItems/HotelCheckOut.dart';
import 'package:budi/HomePageItems/HotelsDetailPage.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class HotelReviews extends StatefulWidget {
  const HotelReviews({Key? key}) : super(key: key);

  @override
  State<HotelReviews> createState() => _HotelReviewsState();
}

class _HotelReviewsState extends State<HotelReviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 450,
              child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/ic_HotelReview.png',
                            height: 180,
                            width: 120,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
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
                                  height: 10,
                                ),
                                getSemiBoldText(
                                    msg: 'Fantastic Hotel',
                                    fontSize: 16,
                                    color: AppColor.BUTTON_COLOR),
                                SizedBox(
                                  height: 10,
                                ),
                                getRegularStyleText(
                                    msg:
                                    'My family and I had a fantastic time\n with James as our Tour guide!  He is\n definitely a cut above the rest as he...',
                                    textAlign: TextAlign.center,
                                    fontSize: 12),
                                SizedBox(
                                  height: 10,
                                ),
                                getRegularStyleText(
                                    msg: 'Jake Stevens',
                                    fontSize: 12,
                                    color: AppColor.TEXT_COLOR)
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(height: 10,),
            // AppButton(
            //   width: MediaQuery.of(context).size.width,
            //   height: 55,
            //   color: AppColor.BUTTON_COLOR,
            //   label: 'Book Now',
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => HotelCheckOut()));
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
