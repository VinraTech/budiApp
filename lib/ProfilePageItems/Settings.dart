import 'dart:convert';
import 'package:budi/Helpers/ToastMessage.dart';
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

  List<String> _names = [
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: signOutButton(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
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
      body: settingTabOptions(_names, logoOne),
    );
  }

  settingTabOptions(List<String> names, List<String> logo) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
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
                      margin: EdgeInsets.only(left: 18, right: 15),
                      color: Colors.white,
                      height: 55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  padding: EdgeInsets.all(6.0),
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
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  names[index],
                                  style: TextStyle(
                                      color:AppColor.GOOGLETEXT_COLOR,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          index == 3 ? Container(
                              margin: EdgeInsets.only(bottom: 5,),
                              height: 10,
                              child: Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                    activeColor: AppColor.BUTTON_COLOR,
                                    value: isStreamed != null ? isStreamed : false,
                                    onChanged: (bool value) {
                                      setState(() {
                                        isStreamed = value;
                                      });
                                    },
                                  ))):Icon(
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
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => BudiAppBalance()));
    } else if (index == 6) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ContactUs()));
    }
    // else if (index == 2) {
    //   navigationPush(context, MeetingListPage(), function: (v) {});
    // } else if (profileType == 'Customer' ? index == 14 : index == 3) {
    //   navigationPush(context, OrderThreeDFormPage(), function: (v) {});
    // } else if (profileType == 'Customer' ? index == 15 : index == 4) {
    //   navigationPush(context, HomesInfraPricePackage(), function: (v) {});
    // } else if (profileType == 'Customer' ? index == 3 : index == 16) {
    //   navigationPush(
    //       context,
    //       InAppWebViewExampleScreen(
    //         virtualReality: true,
    //         title: 'Virtual Reality',
    //       ),
    //       function: (v) {});
    // } else if (profileType == 'Architect' || profileType == 'Interior Designer'
    //     ? index == 5
    //     : index == 4) {
    //   navigationPush(
    //       context,
    //       ResetPassword(
    //         userMobile: userInfoModel!.userInformation!.mobile!,
    //         isProfile: true,
    //       ),
    //       function: (v) {});
    // } else if (profileType == 'Architect' || profileType == 'Interior Designer'
    //     ? index == 6
    //     : index == 5) {
    //   navigationPush(
    //       context,
    //       InAppWebViewExampleScreen(
    //         title: StringConstant.termsAndTheCondition,
    //       ),
    //       function: (v) {});
    //   // navigationPush(
    //   //     context,
    //   //     TermsAndConditionsPage(
    //   //       titleAppBar: StringConstant.termsAndTheCondition,
    //   //       pageType: StringConstant.terms,
    //   //     ),
    //   //     function: (v) {});
    // } else if (profileType == 'Architect' || profileType == 'Interior Designer'
    //     ? index == 7
    //     : index == 6) {
    //   navigationPush(
    //       context,
    //       InAppWebViewExampleScreen(
    //         aboutUs: false,
    //         title: StringConstant.privacyOfPolicy,
    //       ),
    //       function: (v) {});
    //   // navigationPush(
    //   //     context,
    //   //     TermsAndConditionsPage(
    //   //       titleAppBar: StringConstant.privacyandPolicy,
    //   //       pageType: StringConstant.privacyOfPolicy,
    //   //     ),
    //   //     function: (v) {});
    // } else if (profileType == 'Architect' || profileType == 'Interior Designer'
    //     ? index == 8
    //     : index == 7) {
    //   showReplyDialog(context, feedbackController, onTap: () {
    //     Navigator.of(context, rootNavigator: true).pop();
    //     AppNetworkManager.deleteUserAccount(context, (result, isSuccess) {
    //       if (isSuccess == true) {
    //         logoutButtonPressed(context);
    //       }
    //     });
    //   });
    // } else if (profileType == 'Architect' || profileType == 'Interior Designer'
    //     ? index == 9
    //     : index == 8) {
    //   navigationPush(
    //       context,
    //       InAppWebViewExampleScreen(
    //         aboutUs: true,
    //         title: StringConstant.aboutUs,
    //       ),
    //       function: (v) {});
    //   // navigationPush(
    //   //     context,
    //   //     TermsAndConditionsPage(
    //   //         titleAppBar: StringConstant.aboutUs,
    //   //         pageType: StringConstant.aboutus),
    //   //     function: (v) {});
    // } else if (profileType == 'Architect' || profileType == 'Interior Designer'
    //     ? index == 10
    //     : index == 9) {
    //   logoutButtonPressed(context);
    // } else if (profileType == 'Architect' || profileType == 'Interior Designer'
    //     ? index == 0
    //     : index == 11) {
    //   navigationPush(context, ThreeDList(), function: (v) {});
    // }
  }

  logoutEveryWhere() async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('LogInToken');
      var params = {"": ""};
      AppIndicator.loadingIndicator();
      final url =
      Uri.parse('http://74.208.150.111/api/logout_everywhere');
      var request = http.MultipartRequest(
          'POST', url)..fields.addAll(params);
      request.headers.addAll({
        'Authorization': 'Bearer ' + token!,
        'Accept': 'application/json',
        // 'Content-Type': 'multipart/form-data'
      });
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      var encoded = json.decode(respStr);
      final int statusCode = url.port;
      StatusMessage data = StatusMessage.fromJson(encoded);
      if (response.statusCode == 200) {
        StatusMessage? statusMessage;
        AppIndicator.disposeIndicator();
        statusMessage = data;
        SharedPreferenceManager.deleteSavedDetails(context,data.message!);
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
        onTap: (){
          logoutEveryWhere();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 35,
              width: 35,
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColor.BACKGROUND_COLOR.withOpacity(0.5)),
              child: Image.asset(
                Assets.icLogout,
                height: 25,
                width: 25,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
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
