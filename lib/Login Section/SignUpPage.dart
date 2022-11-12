import 'package:budi/BottomNavigation.dart';
import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/Common%20Fields/AppTextField.dart';
import 'package:budi/Common%20Fields/SocialLoginButton.dart';
import 'package:budi/Login%20Section/LoginPage.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

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
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>BottomNavigation()));
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
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
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
}
