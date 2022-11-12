import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/Common%20Fields/AppTextField.dart';
import 'package:budi/Login%20Section/PasswordVerification.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:flutter/material.dart';

class ConfirmPassword extends StatefulWidget {
  const ConfirmPassword({Key? key}) : super(key: key);

  @override
  State<ConfirmPassword> createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => PasswordVerification()));
                },
              )
            ],
          ),
        ));
  }
}
