import 'dart:convert';
import 'package:budi/LoginManager/SharedPreferenceManager.dart';
import 'package:http/http.dart' as http;
import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/Common%20Fields/AppTextField.dart';
import 'package:budi/Helpers/AppIndicator.dart';
import 'package:budi/Helpers/ToastMessage.dart';
import 'package:budi/Login%20Section/PasswordVerification.dart';
import 'package:budi/Models/UserInfoModel.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmPassword extends StatefulWidget {
  String? forgotToken;
  String? pageType;

  ConfirmPassword({Key? key, this.forgotToken, this.pageType})
      : super(key: key);

  @override
  State<ConfirmPassword> createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
              AppTextField(
                controller: newPasswordController,
                obscureText: true,
                enable: true,
                prefixIcon: Assets.ic_PasswordIcon,
                hintText: 'Enter new password',
              ),
              AppTextField(
                controller: confirmPasswordController,
                obscureText: true,
                enable: true,
                prefixIcon: Assets.ic_PasswordIcon,
                hintText: 'Confirm new password',
              ),
              AppButton(
                width: MediaQuery.of(context).size.width,
                height: 55,
                color: AppColor.BUTTON_COLOR,
                label: 'Confirm',
                onTap: () {
                  if (newPasswordController.text !=
                      confirmPasswordController.text) {
                    ToastMessage.message('Password Does Not Match');
                  } else if (newPasswordController.text == '' ||
                      confirmPasswordController.text == '') {
                    ToastMessage.message('All Fields Are Required');
                  } else {
                    widget.pageType == 'reset'
                        ? resetPassword(newPasswordController.text,
                            confirmPasswordController.text)
                        : confirmPassword(newPasswordController.text,
                            confirmPasswordController.text);
                  }
                },
              )
            ],
          ),
        ));
  }

  confirmPassword(String newPassword, String confirmPassword) async {
    try {
      var params = {
        "password": newPassword,
        "password_confirmation": confirmPassword,
      };
      AppIndicator.loadingIndicator();
      final url = Uri.parse('http://74.208.150.111/api/reset_password');
      var request = http.MultipartRequest('POST', url)..fields.addAll(params);
      request.headers.addAll({
        'Authorization': 'Bearer ${widget.forgotToken!}',
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
        ToastMessage.message(data.message);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const PasswordVerification()),
            (Route<dynamic> route) => false);
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => PasswordVerification()));
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

  resetPassword(String newPassword, String confirmPassword) async {
    try {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('LogInToken');
      var params = {
        "password": newPassword,
        "password_confirmation": confirmPassword,
      };
      AppIndicator.loadingIndicator();
      final url = Uri.parse('http://74.208.150.111/api/change_password');
      var request = http.MultipartRequest('POST', url)..fields.addAll(params);
      request.headers.addAll({
        'Authorization': 'Bearer $token',
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
        ToastMessage.message(data.message);
        SharedPreferenceManager.deleteSavedDetails(context, data.message!);
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
