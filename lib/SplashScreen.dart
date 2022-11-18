import 'dart:async';
import 'package:budi/BottomNavigation.dart';
import 'package:budi/Login%20Section/UserSelectionPage.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? appVersion, buildNumber;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      navigation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: AppColor.OFF_WHITE_COLOR,
        image: DecorationImage(
          image: AssetImage(Assets.icLogo,),
          // fit: BoxFit.fill,
          alignment: Alignment.center,
        ),
      ),
    );
  }

  void navigation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var isEmail = sharedPreferences.getString('userEmail');
    if (isEmail != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => BottomNavigation(),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => UserSelectionPage(),
        ),
      );
    }
  }
}
