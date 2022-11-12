import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/IntroPage/IntroScreen.dart';
import 'package:budi/Login%20Section/LoginPage.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:flutter/material.dart';

class UserSelectionPage extends StatefulWidget {
  const UserSelectionPage({Key? key}) : super(key: key);

  @override
  State<UserSelectionPage> createState() => _UserSelectionPageState();
}

class _UserSelectionPageState extends State<UserSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.OFF_WHITE_COLOR,
      body: Column(
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
          AppButton(
            width: MediaQuery.of(context).size.width,
            height: 55,
            color: AppColor.BUTTON_COLOR,
            label: 'I am an user',
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => IntroScreen(role: 'user',)));
            },
          ),
          AppButton(
            width: MediaQuery.of(context).size.width,
            height: 55,
            color: AppColor.BUTTON_COLOR,
            label: 'I am an agent',
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => IntroScreen(role: 'agent',)));
            },
          )
        ],
      ),
    );
  }
}
