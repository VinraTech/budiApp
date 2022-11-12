import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/Common%20Fields/MySeparator.dart';
import 'package:budi/HomePageItems/PaymentDonePage.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class CheckOutPayment extends StatefulWidget {
  bool? carRent;
  bool? isProfile;

  CheckOutPayment({Key? key, this.carRent, this.isProfile}) : super(key: key);

  @override
  State<CheckOutPayment> createState() => _CheckOutPaymentState();
}

class _CheckOutPaymentState extends State<CheckOutPayment> {
  List<String> card = [
    'assets/images/ic_creditCard.png',
    'assets/images/ic_visa.png',
    'assets/images/ic_masterCard.png'
  ];
  List<String> cardName = ['Card', 'Visa', 'Master Card'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: AppButton(
          width: MediaQuery.of(context).size.width,
          height: 55,
          color: AppColor.BUTTON_COLOR,
          label: widget.isProfile == true ? 'Add' : 'Checkout',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PaymentDone(
                          carRent: widget.carRent,
                          isProfile: widget.isProfile,
                        )));
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
              msg: widget.isProfile == true ? 'Add payment method' : 'Checkout',
              color: Colors.white,
              fontSize: 16,
            )),
      ),
      backgroundColor: AppColor.OFF_WHITE_COLOR,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cardView(),
            cardDetails(),
            widget.isProfile == true ? billInfo() : amount()
          ],
        ),
      ),
    );
  }

  cardView() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          getSemiBoldText(msg: 'Select payment method', fontSize: 16),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        height: 70,
                        padding: EdgeInsets.only(left: 7, right: 7),
                        margin: EdgeInsets.only(right: 6, left: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.BACKGROUND_COLOR,
                            border: Border.all(
                                width: 1, color: AppColor.TEXT_COLOR)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              card[index],
                              height: 30,
                              width: 30,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            getRegularStyleText(
                              msg: cardName[index],
                              fontSize: 14,
                              color: AppColor.TEXT_COLOR,
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }

  cardDetails() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(15.0),
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
                label: getRegularStyleText(msg: 'Account Holder Name')),
          ),
          SizedBox(
            height: 8,
          ),
          TextField(
            decoration:
                InputDecoration(label: getRegularStyleText(msg: 'Card Number')),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: TextField(
                  decoration: InputDecoration(
                      label: getRegularStyleText(msg: 'Expire Date')),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: TextField(
                  decoration:
                      InputDecoration(label: getRegularStyleText(msg: 'CVV')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  amount() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(15.0),
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getRegularStyleText(
                  msg: 'Hotel Price', color: AppColor.TEXT_COLOR, fontSize: 16),
              getSemiBoldText(msg: '1200', color: AppColor.HOMETEXT)
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getRegularStyleText(
                  msg: 'Tax', color: AppColor.TEXT_COLOR, fontSize: 16),
              getSemiBoldText(msg: '-200', color: AppColor.HOMETEXT)
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getRegularStyleText(msg: 'Promo', color: AppColor.TEXT_COLOR),
              getSemiBoldText(msg: '500', color: AppColor.HOMETEXT)
            ],
          ),
          SizedBox(
            height: 16,
          ),
          MySeparator(),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getRegularStyleText(
                  msg: 'Total Amount', color: AppColor.SIGNIN_COLOR),
              getSemiBoldText(msg: '900', color: AppColor.BUTTON_COLOR)
            ],
          ),
        ],
      ),
    );
  }

  billInfo() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(15.0),
      padding: EdgeInsets.all(15.0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getBoldText(
              msg: 'Billing Info', fontSize: 16, color: AppColor.SIGNIN_COLOR),
          SizedBox(
            height: 5,
          ),
          getRegularStyleText(
              msg: 'Please enter your billing info',
              fontSize: 12,
              color: AppColor.TEXT_COLOR),
          SizedBox(
            height: 8,
          ),
          textField('Full name'),
          SizedBox(
            height: 8,
          ),
          textField('Address'),
          SizedBox(
            height: 8,
          ),
          textField('Phone number'),
          SizedBox(
            height: 8,
          ),
          textField('Town/City'),
        ],
      ),
    );
  }

  textField(String hint) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColor.TEXT_COLOR.withOpacity(0.4)),
        color: AppColor.BACKGROUND_COLOR.withOpacity(0.5),
      ),
      child: TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(color: AppColor.TEXT_COLOR.withOpacity(0.6))),
      ),
    );
  }
}
