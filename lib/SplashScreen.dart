import 'dart:async';
import 'package:budi/BottomNavigation.dart';
import 'package:budi/BottomNavigationScreens/ProfilePage.dart';
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
          image: AssetImage(
            Assets.icLogo,
          ),
          // fit: BoxFit.fill,
          alignment: Alignment.center,
        ),
      ),
    );
  }

  void navigation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var isEmail = sharedPreferences.getString('userEmail');
    var roleType = sharedPreferences.getString('roles');
    if (isEmail != null) {
      if (roleType == 'agent') {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            ProfilePage()), (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => BottomNavigation(),
          ),
        );
      }
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => UserSelectionPage(),
        ),
      );
    }
  }
}
