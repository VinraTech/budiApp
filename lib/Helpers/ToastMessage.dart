import 'package:fluttertoast/fluttertoast.dart';


class ToastMessage {
  static void message(String? message) {
    Fluttertoast.showToast(
      msg: message!,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
