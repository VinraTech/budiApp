import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:flutter/material.dart';

class SocialLoginButton extends StatefulWidget {
  VoidCallback googlePressed;
  VoidCallback facebookPressed;

  SocialLoginButton(
      {Key? key, required this.facebookPressed, required this.googlePressed})
      : super(key: key);

  @override
  State<SocialLoginButton> createState() => _SocialLoginButtonState();
}

class _SocialLoginButtonState extends State<SocialLoginButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          socialButton(Assets.ic_GoogleLogo, Colors.white, 'Google',
              AppColor.GOOGLETEXT_COLOR,widget.googlePressed),
          socialButton(Assets.icFacebookLogo, AppColor.FACEBOOK_COLOR,
              'Facebook', Colors.white,widget.facebookPressed)
        ],
      ),
    );
  }

  socialButton(
      String? image, Color backgroundColor, String? lable, Color textColor,VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: backgroundColor,
        ),
        height: 50,
        width: MediaQuery.of(context).size.width / 2.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image!,
              height: 25,
              width: 25,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              lable!,
              style: TextStyle(color: textColor, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
