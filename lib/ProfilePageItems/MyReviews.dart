import 'package:budi/Common%20Fields/AppDailogBox.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class MyReviews extends StatefulWidget {
  const MyReviews({Key? key}) : super(key: key);

  @override
  State<MyReviews> createState() => _MyReviewsState();
}

class _MyReviewsState extends State<MyReviews> {
  List<String> travelOptions = ['Latest', 'All Ratings', 'Hotels'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              msg: '21 Reviews',
              color: Colors.white,
              fontSize: 16,
            )),
      ),
      backgroundColor: AppColor.OFF_WHITE_COLOR,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          children: [
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
                            width: 100,
                            child: getRegularStyleText(
                              msg: travelOptions[index],
                              color: AppColor.HOMETEXT,
                              fontSize: 14,
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(48),
                                color: Colors.white)),
                      ],
                    );
                  }),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [notificationSummary()],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  notificationSummary() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 10, right: 10),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 6,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              starIcon(Icons.star, 12),
              starIcon(Icons.star, 12),
              starIcon(Icons.star, 12),
              starIcon(Icons.star, 12),
              starIcon(Icons.star, 12),
            ],
          ),
          SizedBox(height: 8,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getRegularStyleText(
                  msg: 'Great service!',
                  fontSize: 16,
                  color: AppColor.SIGNIN_COLOR),
              getRegularStyleText(
                  msg:
                  'However rare side effects observed among children \ncan be metabolic acidosis, coma, respiratory \ndepression, and hypoglycemia-a',
                  fontSize: 12,
                  color: AppColor.TEXT_COLOR),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  getRegularStyleText(msg: 'Barone LLC.', fontSize: 12, color: AppColor.TEXT_COLOR),
                  SizedBox(width: 40,),
                  getRegularStyleText(msg: '2020-05-22', fontSize: 12, color: AppColor.TEXT_COLOR),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
