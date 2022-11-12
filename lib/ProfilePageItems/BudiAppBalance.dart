import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/HomePageItems/CheckOutPayment.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class BudiAppBalance extends StatefulWidget {
  const BudiAppBalance({Key? key}) : super(key: key);

  @override
  State<BudiAppBalance> createState() => _BudiAppBalanceState();
}

class _BudiAppBalanceState extends State<BudiAppBalance> {

  List<String> image = ['assets/images/ic_masterCard.png','assets/images/ic_logos_paypal.png'];
  List<String> title = ['Master Card','PayPal'];
  List<String> cardNumber = ['**** **** **** 6259','pa*****11@gmail.com'];
  List<String> date = ['12/26',''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: AppButton(
          width: MediaQuery.of(context).size.width,
          height: 55,
          color: AppColor.BUTTON_COLOR,
          label: 'Add new method',
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CheckOutPayment(isProfile: true,)));
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
              msg: 'Budi App Balance',
              color: Colors.white,
              fontSize: 16,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getSemiBoldText(
                msg: 'Your current Budi App balance is',
                fontSize: 16,
                color: AppColor.SIGNIN_COLOR),
            SizedBox(
              height: 5,
            ),
            getExtraBoldStyleText(
                msg: '332.78 USD', fontSize: 20, color: AppColor.LABLE_COLOR),
            SizedBox(
              height: 60,
            ),
            getSemiBoldText(
                msg: 'Your payment methods',
                fontSize: 16,
                color: AppColor.SIGNIN_COLOR),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return cardView(title[index], cardNumber[index], date[index],image[index]);
                    }))
          ],
        ),
      ),
    );
  }

  cardView(String title,String card, String date, String image) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
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
              child: Image.asset(image),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getRegularStyleText(
                    msg: title,
                    color: AppColor.TEXT_COLOR,
                    fontSize: 14),
                getRegularStyleText(
                    msg: card,
                    color: AppColor.SIGNIN_COLOR,
                    fontSize: 16),
                getRegularStyleText(
                    msg: date, color: AppColor.TEXT_COLOR, fontSize: 14),
              ],
            )
          ],
        ),
      ),
    );
  }
}
