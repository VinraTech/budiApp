import 'package:budi/Login%20Section/LoginPage.dart';
import 'package:budi/Models/UserInfoModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  static SharedPreferenceManager? _instance;

  SharedPreferenceManager._();

  static SharedPreferenceManager get getInstance => _instance ??= SharedPreferenceManager._();
  UserInfoModel? _userDetails;

  updateUserDetails(UserInfoModel userInfoModel) {
    this._userDetails = userInfoModel;
    saveUserDetailsInCache(userInfoModel);
  }

  static Future<String?> loggedInUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("UserId");
  }

  Future<UserInfoModel> currentUser() async {
    if (this._userDetails == null) {
      await populateUserModalFromSavedData();
    }
    return this._userDetails!;
  }

  populateUserModalFromSavedData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.get("UserId");
  }

  static Future<String?> getProfileType() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("ProfileType");
  }

  saveUserDetailsInCache(UserInfoModel userInfoModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("IsLogin", userInfoModel.user?.email ?? "");
    sharedPreferences.setString("UserId", userInfoModel.user?.id.toString() ?? "");
    sharedPreferences.setString("name", userInfoModel.user?.name ?? "");
    sharedPreferences.setString("userEmail", userInfoModel.user?.email ?? "");
    sharedPreferences.setString("roles", userInfoModel.user?.roles?[0].name ?? "");
    if (userInfoModel.token != null) {
      sharedPreferences.setString("LogInToken", userInfoModel.token!);
    }
  }

  static deleteSavedDetails(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("IsLogin");
    sharedPreferences.remove("UserId");
    sharedPreferences.remove("name");
    sharedPreferences.remove("userEmail");
    sharedPreferences.remove("roles");
    sharedPreferences.remove("LogInToken");
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false);
    // sharedPreferences.remove("LogInToken");
    // SocialLoginManager.handleSignOut();
  }
}
