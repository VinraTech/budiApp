import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/HomePageItems/TravelInsuranceNextPage.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class TravelInsurance extends StatefulWidget {
  const TravelInsurance({Key? key}) : super(key: key);

  @override
  State<TravelInsurance> createState() => _TravelInsuranceState();
}

class _TravelInsuranceState extends State<TravelInsurance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 12.0, right: 60, left: 60),
          child: AppButton(
            width: MediaQuery.of(context).size.width,
            height: 45,
            color: AppColor.BUTTON_COLOR,
            label: 'Continue',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TravelInsuranceNextPage()));
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
                msg: 'Travel Insurance',
                color: Colors.white,
                fontSize: 16,
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getSemiBoldText(
                    msg: 'What type of trip are you taking?',
                    fontSize: 16,
                    color: AppColor.SIGNIN_COLOR),
                SizedBox(
                  height: 8,
                ),
                cardView('Annual multi-trip', 'Several trips within 12 months'),
                SizedBox(
                  height: 10,
                ),
                cardView('Single trip', 'Several trips within 12 months'),
                SizedBox(
                  height: 10,
                ),
                getSemiBoldText(
                    msg: 'Where are you off to?',
                    fontSize: 16,
                    color: AppColor.SIGNIN_COLOR),
                SizedBox(
                  height: 10,
                ),
                cardView('Europe', 'All EU countries and UK, Irelands'),
                SizedBox(
                  height: 10,
                ),
                cardView('USA, Canada, Mexico and \nCaribbean',
                    'All EU countries and UK, Irelands'),
                SizedBox(
                  height: 10,
                ),
                cardView('Oceania', 'Australia/New Zealand'),
                SizedBox(
                  height: 10,
                ),
                getSemiBoldText(
                    msg: 'Select your trip period',
                    fontSize: 16,
                    color: AppColor.SIGNIN_COLOR),
                SizedBox(
                  height: 10,
                ),
                checkIn()
              ],
            ),
          ),
        ));
  }

  cardView(String msg, String desc) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              margin: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColor.SIGNIN_COLOR),
            ),
            SizedBox(
              width: 15,
            ),
            title(msg, desc),
          ],
        ),
      ),
    );
  }

  title(String msg, String desc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getSemiBoldText(msg: msg, fontSize: 16, color: AppColor.SIGNIN_COLOR),
        getRegularStyleText(msg: desc, fontSize: 14, color: AppColor.HOMETEXT)
      ],
    );
  }

  checkIn() {
    return Container(
      padding: EdgeInsets.only(left: 20),
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getSemiBoldText(
                      msg: 'Start', fontSize: 12, color: AppColor.TEXT_COLOR),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      getRegularStyleText(msg: '20 July 2022', fontSize: 12),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        'assets/images/ic_down.png',
                        height: 15,
                        width: 15,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                height: 40,
                width: 2,
                color: AppColor.TEXT_COLOR,
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getSemiBoldText(
                      msg: 'End', fontSize: 12, color: AppColor.TEXT_COLOR),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      getRegularStyleText(msg: '20 July 2022', fontSize: 12),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        'assets/images/ic_down.png',
                        height: 15,
                        width: 15,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
