import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class TravelInsuranceNextPage extends StatefulWidget {
  const TravelInsuranceNextPage({Key? key}) : super(key: key);

  @override
  State<TravelInsuranceNextPage> createState() => _TravelInsuranceNextPageState();
}

class _TravelInsuranceNextPageState extends State<TravelInsuranceNextPage> {
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
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => TravelInsuranceNextPage()));
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
                    msg: 'Tell us whos travelling',
                    fontSize: 16,
                    color: AppColor.SIGNIN_COLOR),
                SizedBox(
                  height: 8,
                ),
                cardView('One person', 'single person trip'),
                SizedBox(
                  height: 10,
                ),
                cardView('Couple', 'Two people in a relationship living at the \nsame address'),
                SizedBox(
                  height: 10,
                ),
                cardView('Family', 'Up to two adults and up to three children \nunder the age of 18'),
                SizedBox(
                  height: 10,
                ),
                getSemiBoldText(
                    msg: 'Do any of these travellers have a pre-\nexisting medical condition?',
                    fontSize: 16,
                    color: AppColor.SIGNIN_COLOR),
                SizedBox(
                  height: 10,
                ),
                cardView('No', 'I do not have any medical conditions'),
                SizedBox(
                  height: 10,
                ),
                cardView('Yes',
                    'I do have any medical conditions'),
                SizedBox(
                  height: 10,
                ),
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
}
