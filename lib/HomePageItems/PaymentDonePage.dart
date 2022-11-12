import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class PaymentDone extends StatefulWidget {
  bool? carRent;
  bool? isProfile;
  bool? contactUs;

  PaymentDone({Key? key, this.carRent, this.isProfile,this.contactUs}) : super(key: key);

  @override
  State<PaymentDone> createState() => _PaymentDoneState();
}

class _PaymentDoneState extends State<PaymentDone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.OFF_WHITE_COLOR,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 60),
                height: MediaQuery.of(context).size.width / 1.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      Assets.icLogo,
                    ),
                    // fit: BoxFit.fill,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: widget.contactUs == true?getRegularStyleText(
                    msg:
                    'Your request has been recieved. We will \nget back to you shortly!',
                    textAlign: TextAlign.center,
                    color: AppColor.GREEN_TEXT_COLOR,
                    fontSize: 16): widget.isProfile == true
                        ? getRegularStyleText(
                            msg:
                                'New payment method added.\nYou can use the new payment method \nfrom your next paments!',
                            textAlign: TextAlign.center,
                            color: AppColor.GREEN_TEXT_COLOR,
                            fontSize: 16)
                        : widget.carRent == true
                            ? getRegularStyleText(
                                msg:
                                    'Conratulations!\nYour checkout has been completed!\nYou will recieve the confirmation via\n email shortly!',
                                textAlign: TextAlign.center,
                                color: AppColor.GREEN_TEXT_COLOR,
                                fontSize: 16)
                            : Text(
                                'Congrats!\n \nYour booking has been completed!',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColor.GREEN_TEXT_COLOR,
                                ),
                                textAlign: TextAlign.center,
                              )),
              ),
            ],
          ),
        ));
  }
}
