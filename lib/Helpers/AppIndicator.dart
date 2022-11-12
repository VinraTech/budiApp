import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppIndicator {
  static Future<void> loadingIndicator() async {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorSize = 45.0
      ..radius = 8.0
      ..progressColor = Colors.white24
      ..backgroundColor = Colors.white24
      ..indicatorColor = Color(0xfff5af5b)
      ..textColor = Color(0xfff5af5b)
      ..maskColor = Colors.white.withOpacity(0.5)
      ..maskType = EasyLoadingMaskType.custom
      ..userInteractions = false;
    EasyLoading.show(status: 'loading...',);
  }

  static Future<void> disposeIndicator() async {
    EasyLoading.dismiss();
  }
}
