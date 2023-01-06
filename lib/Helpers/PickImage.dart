import 'package:budi/ProfilePageItems/EditProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage{
  static Future<void> pickImage(ImageSource imageSource, BuildContext context,
      ResponseHandler responseHandler) async {
    try {
      var picture =
      await ImagePicker().pickImage(source: imageSource, imageQuality: 35);
      if (picture != null) {
        responseHandler(picture, true);
      } else {
        responseHandler(null, false);
      }
    } on PlatformException catch (e) {
      responseHandler(null, false);
    }
  }
}