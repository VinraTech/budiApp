import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
              msg: 'Notification',
              color: Colors.white,
              fontSize: 16,
            )),
        actions: [
          Image.asset(Assets.icFilter),
          Image.asset(
            Assets.ic_Search,
            color: Colors.white,
            height: 20,
            width: 20,
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 15, right: 15,top: 15),
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getRegularStyleText(
                      msg: 'Today', fontSize: 16, color: AppColor.SIGNIN_COLOR),
                  SizedBox(height: 10,),
                  notificationSummary()
                ],
              );
            }),
      ),
    );
  }

  notificationSummary() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Image.asset(
                'assets/images/ic_notificationDemo.png',
                height: 100,
                width: 100,
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // width: MediaQuery.of(context).size.width * 0.4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          getRegularStyleText(
                              msg: 'Agent responded',
                              fontSize: 16,
                              color: AppColor.SIGNIN_COLOR),
                          Container(
                            height: 25,
                            width: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColor.GREEN_TEXT_COLOR),
                            child: getRegularStyleText(msg: 'Bid'),
                          )
                        ],
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     starIcon(Icons.star, 12),
                    //     starIcon(Icons.star, 12),
                    //     starIcon(Icons.star, 12),
                    //     starIcon(Icons.star, 12),
                    //     starIcon(Icons.star, 12),
                    //   ],
                    // ),
                    getRegularStyleText(
                        msg:
                            '50 coupon on a 500 product \nsounds much better than a 10% \ndiscount',
                        fontSize: 12,
                        color: AppColor.TEXT_COLOR),
                    SizedBox(
                      height: 10,
                    ),
                    getRegularStyleText(
                        msg: '5:47 pm',
                        fontSize: 12,
                        color: AppColor.TEXT_COLOR),
                  ],
                ),
              )
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
