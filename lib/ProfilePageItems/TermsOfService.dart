import 'dart:convert';
import 'package:budi/Common%20Fields/CircularIndicator.dart';
import 'package:http/http.dart' as http;
import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/Models/TermsAndConditionModel.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermsOfService extends StatefulWidget {
  String? title;
  String? pageType;

  TermsOfService({Key? key, this.title, this.pageType}) : super(key: key);

  @override
  State<TermsOfService> createState() => _TermsOfServiceState();
}

class _TermsOfServiceState extends State<TermsOfService> {
  TermsAndConditionModel? termsOfUse;

  termsAndCondition() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('LogInToken');
      final res = await http.get(
          Uri.parse(
              "http://74.208.150.111/api/user_details/terms_and_conditions"),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          });
      final int statusCode = res.statusCode;
      if (statusCode == 200) {
        Map<String, dynamic> decoded = json.decode(res.body);
        TermsAndConditionModel data = TermsAndConditionModel.fromJson(decoded);
        termsOfUse = data;
        setState(() {});
      } else {
        print(statusCode);
      }
    } catch (exception) {
      print("Please Check Internet");
    }
  }

  privacyPolicy() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('LogInToken');
      final res = await http.get(
          Uri.parse("http://74.208.150.111/api/user_details/privacy_policy"),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          });
      final int statusCode = res.statusCode;
      if (statusCode == 200) {
        Map<String, dynamic> decoded = json.decode(res.body);
        TermsAndConditionModel data = TermsAndConditionModel.fromJson(decoded);
        termsOfUse = data;
        setState(() {});
      } else {
        print(statusCode);
      }
    } catch (exception) {
      print("Please Check Internet");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.pageType == 'Privacy') {
      privacyPolicy();
    } else {
      termsAndCondition();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: widget.pageType == 'terms'
            ? Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppButton(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 45,
                      lableColor: AppColor.BUTTON_COLOR,
                      color: Colors.white,
                      label: 'Cancel',
                      onTap: () {},
                    ),
                    AppButton(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 45,
                      color: AppColor.BUTTON_COLOR,
                      label: 'Accept',
                      onTap: () {},
                    ),
                  ],
                ),
              )
            : Container(
                height: 1,
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
                msg: widget.title,
                color: Colors.white,
                fontSize: 16,
              )),
        ),
        body: termsOfUse != null
            ? Container(
                padding: const EdgeInsets.all(15),
                child: getRegularStyleText(
                    msg: widget.pageType == 'terms'
                        ? termsOfUse?.tAndC?.content ?? ''
                        : termsOfUse?.privacyPolicy?.content ?? ''))
            : circularIndicator(context));
  }
}
