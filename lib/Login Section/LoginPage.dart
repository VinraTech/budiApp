import 'dart:convert';
import 'package:budi/BottomNavigationScreens/ProfilePage.dart';
import 'package:budi/Helpers/ToastMessage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:budi/BottomNavigation.dart';
import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/Common%20Fields/AppTextField.dart';
import 'package:budi/Common%20Fields/SocialLoginButton.dart';
import 'package:budi/Helpers/AppIndicator.dart';
import 'package:budi/Login%20Section/ForgotPassword.dart';
import 'package:budi/Login%20Section/SignUpPage.dart';
import 'package:budi/LoginManager/SharedPreferenceManager.dart';
import 'package:budi/Models/UserInfoModel.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  String? role;
  LoginPage({Key? key,this.role}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserInfoModel? userInfoModel;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPassword(pageType: 'forgot',)));
              },
              child: Text(
                'Forgot password',
                style: TextStyle(color: AppColor.BUTTON_COLOR),
              ),
            ),
            AppButton(
              width: MediaQuery.of(context).size.width,
              height: 55,
              color: AppColor.BUTTON_COLOR,
              label: 'Sign In',
              onTap: () {
                FirebaseMessaging.instance.getToken().then((value) {
                  loginButtonPressed(emailController.text, passwordController.text, widget.role!,value!);
                  // String? token = value;
                  // fcmToken = value;
                });

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => BottomNavigation()));
              },
            ),
            SizedBox(height: 15,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don???t have an account?',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage(role: widget.role,)));
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
            )
          ],
        ),
      ),
    );
  }

  loginButtonPressed(String email, String password,String role,String fcmToken) async {
    try {
      var params = {
        "email": email,
        "password": password,
        "role": role,
        "device_id": fcmToken,
      };
      AppIndicator.loadingIndicator();
      final url =
      Uri.parse('http://74.208.150.111/api/login');
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
      if (response.statusCode == 200) {
        AppIndicator.disposeIndicator();
        userInfoModel = data;
        SharedPreferenceManager.getInstance.updateUserDetails(userInfoModel!);
        if(userInfoModel?.user?.roles?[0].name == 'agent'){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              ProfilePage()), (Route<dynamic> route) => false);
        }else{
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => BottomNavigation(userInfoModel: userInfoModel,)),
                  (Route<dynamic> route) => false);
        }
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
