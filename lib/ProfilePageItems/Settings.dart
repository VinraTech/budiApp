import 'dart:convert';
import 'package:budi/Common%20Fields/CircularIndicator.dart';
import 'package:budi/Helpers/ToastMessage.dart';
import 'package:budi/Login%20Section/ConfirmPassword.dart';
import 'package:budi/Login%20Section/ForgotPassword.dart';
import 'package:budi/Models/TermsAndConditionModel.dart';
import 'package:budi/ProfilePageItems/TermsOfService.dart';
import 'package:http/http.dart' as http;
import 'package:budi/Helpers/AppIndicator.dart';
import 'package:budi/LoginManager/SharedPreferenceManager.dart';
import 'package:budi/Models/UserInfoModel.dart';
import 'package:budi/ProfilePageItems/ContactUs.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isStreamed = true;
  bool value = false;
  final Color activeColor = AppColor.BUTTON_COLOR;
  TermsAndConditionModel? termsOfUse;
  PushNotificationModel? pushNotificationModel;


  final List<String> _names = [
    'Change email',
    'Change password',
    'Privacy',
    'Push notifications',
    'Languages',
    'Help',
    'Contact us',
  ];

  List<String> logoOne = [
    Assets.ic_EmailIcon,
    Assets.ic_PasswordIcon,
    Assets.icArticle,
    Assets.icNotification,
    Assets.icLanguages,
    Assets.icIntrest,
    Assets.icBag,
  ];

  getEnableDisablePushNotification() async {
    try {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('LogInToken');
      final res = await http.get(
          Uri.parse("http://74.208.150.111/api/user_details/"),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          });
      final int statusCode = res.statusCode;
      if (statusCode == 200) {
        Map<String, dynamic> decoded = json.decode(res.body);
        PushNotificationModel data = PushNotificationModel.fromJson(decoded);
        pushNotificationModel = data;
           value = pushNotificationModel!.userDetail!.pushNotifications!;
           setState(() {});
      } else {
        print(statusCode);
      }
    } catch (exception) {
      print("Please Check Internet");
    }
  }

  enableDisableButton(String enableDisable) async {
    SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('LogInToken');
    try {
      var params = {'':''
      };
      final url =
      Uri.parse('http://74.208.150.111/api/user_details/$enableDisable');
      var request = http.MultipartRequest(
          'POST', url)..fields.addAll(params);
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data'
      });
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      var encoded = json.decode(respStr);
      final int statusCode = url.port;
      if (response.statusCode == 200) {
        PushNotificationModel data = PushNotificationModel.fromJson(encoded);
        pushNotificationModel = data;
        value = pushNotificationModel!.userDetail!.pushNotifications!;
        sharedPreferences.setString("push_notifications",pushNotificationModel?.userDetail?.pushNotifications.toString() ?? "");
        setState(() {});
      } else {
        // ToastMessage.message(data.message);
        AppIndicator.disposeIndicator();
        print(statusCode);
      }
    } catch (exception) {
      AppIndicator.disposeIndicator();
      print("Please Check Internet");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getEnableDisablePushNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: signOutButton(),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        backgroundColor: AppColor.BUTTON_COLOR,
        title: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 1.5,
            child: getSemiBoldText(
              msg: 'Settings',
              color: Colors.white,
              fontSize: 16,
            )),
      ),
      body:
      pushNotificationModel != null ?
      settingTabOptions(_names, logoOne)
          : circularIndicator(context),
    );
  }

  settingTabOptions(List<String> names, List<String> logo) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: names.length,
          itemExtent: 60,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                onItemSelection(context, index);
              },
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 18, right: 15),
                      color: Colors.white,
                      height: 55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                padding: const EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: AppColor.BACKGROUND_COLOR
                                        .withOpacity(0.5)),
                                child: Image.asset(
                                  logo[index],
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                names[index],
                                style: const TextStyle(
                                    color: AppColor.GOOGLETEXT_COLOR,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          index == 3
                              ? Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 5,
                                  ),
                                  height: 10,
                                  child: Transform.scale(
                                    scale: 0.8,
                                    child: CupertinoSwitch(
                                      activeColor: activeColor,
                                      value: value,
                                      onChanged: (v) {
                                        if(v == false){
                                          enableDisableButton('disable_push_notifications');
                                        }else{
                                          enableDisableButton('enable_push_notifications');
                                        }
                                        }),
                                    // shaderCallback: (r) {
                                    //   return LinearGradient(
                                    //     colors: value
                                    //         ? [activeColor, activeColor]
                                    //         : [Colors.red, Colors.red],
                                    //   ).createShader(r);
                                    // },
                                  ))
                              : const Icon(
                                  Icons.chevron_right,
                                  color: AppColor.TEXT_COLOR,
                                ),
                        ],
                      )),
                ],
              ),
            );
          }),
    );
  }

  void onItemSelection(BuildContext context, int index) {
    if (index == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ForgotPassword(
                    pageType: 'profile',
                  )));
    } else if (index == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmPassword(
                    pageType: 'reset',
                  )));
    } else if (index == 2) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TermsOfService(
                    title: 'Privacy Policy',
                    pageType: 'Privacy',
                  )));
    } else if (index == 6) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const ContactUs()));
    }
  }

  logoutEveryWhere() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('LogInToken');
      var params = {"": ""};
      AppIndicator.loadingIndicator();
      final url = Uri.parse('http://74.208.150.111/api/logout_everywhere');
      var request = http.MultipartRequest('POST', url)..fields.addAll(params);
      request.headers.addAll({
        'Authorization': 'Bearer ${token!}',
        'Accept': 'application/json',
        // 'Content-Type': 'multipart/form-data'
      });
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      var encoded = json.decode(respStr);
      final int statusCode = url.port;
      ApiResultModel data = ApiResultModel.fromJson(encoded);
      if (response.statusCode == 200) {
        ApiResultModel? statusMessage;
        AppIndicator.disposeIndicator();
        statusMessage = data;
        SharedPreferenceManager.deleteSavedDetails(context, data.message!);
        setState(() {});
      } else {
        ToastMessage.message(data.message);
        AppIndicator.disposeIndicator();
        print(statusCode);
      }
    } catch (exception) {
      AppIndicator.disposeIndicator();
      print("Please Check Internet");
    }
  }

  signOutButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 15),
      child: GestureDetector(
        onTap: () {
          logoutEveryWhere();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 35,
              width: 35,
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColor.BACKGROUND_COLOR.withOpacity(0.5)),
              child: Image.asset(
                Assets.icLogout,
                height: 25,
                width: 25,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            const Text(
              'Sign Out',
              style: TextStyle(
                  color: AppColor.RED_COLOR, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
