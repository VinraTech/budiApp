import 'dart:convert';
import 'package:budi/BottomNavigation.dart';
import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/Common%20Fields/AppTextField.dart';
import 'package:budi/Common%20Fields/SocialLoginButton.dart';
import 'package:budi/Helpers/AppIndicator.dart';
import 'package:budi/Helpers/ToastMessage.dart';
import 'package:budi/LoginManager/SharedPreferenceManager.dart';
import 'package:budi/Models/UserInfoModel.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class SignUpPage extends StatefulWidget {
  String? role;

  SignUpPage({Key? key,this.role}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  UserInfoModel? userInfoModel;


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
                controller: fullNameController,
                obscureText: false,
                enable: true,
                prefixIcon: Assets.icAccountIcon,
                hintText: 'Full Name',
              ),
              AppTextField(
                controller: emailController,
                obscureText: false,
                enable: true,
                prefixIcon: Assets.ic_EmailIcon,
                hintText: 'Email',
              ),
              AppTextField(
                controller: passwordController,
                obscureText: true,
                enable: true,
                prefixIcon: Assets.ic_PasswordIcon,
                hintText: 'Password',
              ),
              AppButton(
                width: MediaQuery.of(context).size.width,
                height: 55,
                color: AppColor.BUTTON_COLOR,
                label: 'Sign Up',
                onTap: () {
                  signInButtonPressed(fullNameController.text, emailController.text, passwordController.text, widget.role!);
                },
              ),
              SizedBox(height: 15,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>BottomNavigation()));                    },
                    child: Text(
                      ' Sign In',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColor.BUTTON_COLOR,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 60),
                child: Text(
                  'Or Sign in with',
                  style: TextStyle(fontSize: 14, color: AppColor.SIGNIN_COLOR),
                ),
              ),
              SocialLoginButton(
                googlePressed: () {},
                facebookPressed: () {},
              ),
              SizedBox(height: 30,)
            ],
          ),
        ));
  }

  signInButtonPressed(String name,String email, String password,String role) async {
    try {
      var params = {
        'name': name,
        "email": email,
        "password": password,
        "role": role,
      };
      AppIndicator.loadingIndicator();
      final url =
      Uri.parse('http://74.208.150.111/api/register');
      var request = http.MultipartRequest(
          'POST', url)..fields.addAll(params);
      request.headers.addAll({
        // 'Authorization': '',
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data'
      });
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      var encoded = json.decode(respStr);
      final int statusCode = url.port;
      UserInfoModel data = UserInfoModel.fromJson(encoded);
      if (response.statusCode == 201) {
        userInfoModel = data;
        AppIndicator.disposeIndicator();
        SharedPreferenceManager.getInstance.updateUserDetails(userInfoModel!);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => BottomNavigation()),
                (Route<dynamic> route) => false);
        ToastMessage.message(data.message);
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
