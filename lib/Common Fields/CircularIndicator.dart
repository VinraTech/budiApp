import 'package:budi/Utilities/AppColor.dart';
import 'package:flutter/material.dart';

Widget circularIndicator(BuildContext context){
  return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/splash_bg.png"),
          fit: BoxFit.cover,
          alignment: Alignment.center,
          repeat: ImageRepeat.noRepeat,
        ),
      ),
      child: const CircularProgressIndicator(
        color: AppColor.BUTTON_COLOR,
      ));
}