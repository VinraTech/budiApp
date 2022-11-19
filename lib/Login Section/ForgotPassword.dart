import 'dart:convert';
import 'package:budi/Models/UserInfoModel.dart';
import 'package:http/http.dart' as http;
import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/Common%20Fields/AppTextField.dart';
import 'package:budi/Helpers/AppIndicator.dart';
import 'package:budi/Helpers/ToastMessage.dart';
import 'package:budi/Login%20Section/ConfirmPassword.dart';
import 'package:budi/Login%20Section/SignUpPage.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

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
              Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: Text(
                    'Please enter the email you are \n registered with',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.TEXT_COLOR,
                    ),
                    textAlign: TextAlign.center,
                  )),
              AppTextField(
                controller: emailController,
                obscureText: false,
                enable: true,
                prefixIcon: Assets.ic_EmailIcon,
                hintText: 'Email',
              ),
              AppButton(
                width: MediaQuery.of(context).size.width,
                height: 55,
                color: AppColor.BUTTON_COLOR,
                label: 'Send',
                onTap: () {
                  emailController.text == ''
                      ? ToastMessage.message('Email Is Required')
                      : forgotPassword(emailController.text);
                },
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t have an account?',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    },
                    child: Text(
                      ' Sign Up',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColor.BUTTON_COLOR,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  forgotPassword(String email) async {
    try {
      var params = {
        "email": email,
      };
      AppIndicator.loadingIndicator();
      final url = Uri.parse('http://74.208.150.111/api/forgot_password');
      var request = http.MultipartRequest('POST', url)..fields.addAll(params);
      request.headers.addAll({
        // 'Authorization': '',
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data'
      });
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      var encoded = json.decode(respStr);
      final int statusCode = url.port;
      ApiResultModel data = ApiResultModel.fromJson(encoded);
      if (response.statusCode == 200) {
        ApiResultModel? apiResultModel;
        AppIndicator.disposeIndicator();
        apiResultModel = data;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConfirmPassword(
                      forgotToken: apiResultModel?.token,
                    )));
        setState(() {});
      } else {
        ToastMessage.message(data.message);
        AppIndicator.disposeIndicator();
        print(statusCode);
      }
    } catch (exception) {
      AppIndicator.disposeIndicator();
      print("Please Check Internet");
    }
  }
}
