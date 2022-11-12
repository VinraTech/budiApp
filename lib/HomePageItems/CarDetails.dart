import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/Common%20Fields/AppDailogBox.dart';
import 'package:budi/HomePageItems/HotelCheckOut.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class CarDetails extends StatefulWidget {
  const CarDetails({Key? key}) : super(key: key);

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: AppButton(
          width: MediaQuery.of(context).size.width,
          height: 55,
          color: AppColor.BUTTON_COLOR,
          label: 'Rent Now',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HotelCheckOut(
                          carRent: true,
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
              msg: 'Audi A6',
              color: Colors.white,
              fontSize: 16,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              topView(),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  boxView('Engine Type', 'Gas', 12),
                  boxView('Transition', 'Automatic', 12),
                  boxView('Horsepower', ' 321 bhp', 12),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              getSemiBoldText(
                  msg: 'Car Renter',
                  fontSize: 16,
                  color: AppColor.SIGNIN_COLOR),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.greenAccent[400],
                      radius: 30,
                      child:
                          Image.asset('assets/images/ic_carRenter.png'), //Text
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  getSemiBoldText(
                      msg: 'Wade Waren',
                      fontSize: 16,
                      color: AppColor.SIGNIN_COLOR)
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 70),
                child: getSemiBoldText(
                    msg: 'Rennerstr. 95,	Wermelskirchen \nBayern,	62052, DE',
                    fontSize: 12,
                    color: AppColor.HOMETEXT),
              ),
            ],
          ),
        ),
      ),
    );
  }

  boxView(String msg, String msg2, double fontSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 80,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(color: AppColor.TEXT_COLOR)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getRegularStyleText(
                  msg: msg, fontSize: fontSize, color: AppColor.TEXT_COLOR),
              SizedBox(
                height: 10,
              ),
              getRegularStyleText(
                msg: msg2,
                fontSize: 12,
                color: AppColor.HOMETEXT,
              ),
            ],
          ),
        )
      ],
    );
  }

  topView() {
    return Column(
      children: [
        Image.asset('assets/images/ic_CarDetail.png'),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getSemiBoldText(
                msg: 'Audi X12', fontSize: 16, color: AppColor.SIGNIN_COLOR),
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
            textView('/Day', 14, AppColor.TEXT_COLOR)
          ],
        ),
      ],
    );
  }
}
