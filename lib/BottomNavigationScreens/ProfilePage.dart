import 'dart:convert';
import 'package:budi/Common%20Fields/CircularIndicator.dart';
import 'package:budi/Models/ProfileDetailModel.dart';
import 'package:budi/ProfilePageItems/EditProfilePage.dart';
import 'package:http/http.dart' as http;
import 'package:budi/Helpers/AppIndicator.dart';
import 'package:budi/Helpers/ToastMessage.dart';
import 'package:budi/LoginManager/SharedPreferenceManager.dart';
import 'package:budi/Models/UserInfoModel.dart';
import 'package:budi/ProfilePageItems/BudiAppBalance.dart';
import 'package:budi/ProfilePageItems/InviteFirends.dart';
import 'package:budi/ProfilePageItems/MyReviews.dart';
import 'package:budi/ProfilePageItems/Notification.dart';
import 'package:budi/ProfilePageItems/Settings.dart';
import 'package:budi/ProfilePageItems/TermsOfService.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileDetailModel? profileDetailModel;

  List<String> _names = [
    'BUDI App Balance',
    'BUDI tokens',
    'BUDI points',
    'BUDI top up',
    'Account information',
    'Notifications',
    'Invite friends',
    'Interest',
    'Your reviews',
    'Places visited',
    'Find agent',
    'Find trip',
    'Find experience',
    'Terms and conditions',
    'Settings',
    'Sign Out',
  ];

  List<String> logoOne = [
    Assets.icCreditCard,
    Assets.icTokens,
    Assets.icPoints,
    Assets.icTopUp,
    Assets.icAccountIcon,
    Assets.icNotification,
    Assets.icInvite,
    Assets.icIntrest,
    Assets.icReviews,
    Assets.icUmbrella,
    Assets.icNavigation,
    Assets.icFindPlace,
    Assets.icCompass,
    Assets.icArticle,
    Assets.icSetting,
    Assets.icLogout,
  ];

  Future<void> getProfileDetails() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('LogInToken');
      final res = await http
          .get(Uri.parse("http://74.208.150.111/api/profile/show"), headers: {
        'Authorization': 'Bearer ${token}',
        'Accept': 'application/json',
      });
      final int statusCode = res.statusCode;
      if (statusCode == 200) {
        Map<String, dynamic> decoded = json.decode(res.body);
        ProfileDetailModel data = ProfileDetailModel.fromJson(decoded);
        profileDetailModel = data;
        setState(() {});
      } else {
        print(statusCode);
      }
    } catch (exception) {
      print("Please Check Internet");
    }
  }

  @override
  void initState() {
    getProfileDetails();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.OFF_WHITE_COLOR,
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back_rounded,
        //     size: 25,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context, true);
        //   },
        // ),
        backgroundColor: AppColor.BUTTON_COLOR,
        title: Container(
            alignment: Alignment.center,
            // width: MediaQuery.of(context).size.width / 1.5,
            width: MediaQuery.of(context).size.width,
            child: getSemiBoldText(
              msg: 'Profile',
              color: Colors.white,
              fontSize: 16,
            )),
      ),
      body: profileDetailModel != null
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 25),
                        width: MediaQuery.of(context).size.width,
                        height: 220,
                        color: Colors.white,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  profileDetailModel?.profile?.profilePicture ??
                                      ''),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Joshua Jones',
                              style: TextStyle(
                                  color: AppColor.SIGNIN_COLOR, fontSize: 16),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                shareIconView(Assets.icinstagramIcon, () {
                                  _launchURL(profileDetailModel
                                          ?.profile?.instagramHandle ??
                                      ' ');
                                }),
                                SizedBox(
                                  width: 10,
                                ),
                                shareIconView(Assets.icTikTokIcon, () {
                                  _launchURL(profileDetailModel
                                          ?.profile?.tiktokHandle ??
                                      ' ');
                                }),
                                SizedBox(
                                  width: 10,
                                ),
                                shareIconView(Assets.icBlackFacebookIcon, () {
                                  _launchURL(profileDetailModel
                                          ?.profile?.facebookHandle ??
                                      ' ');
                                }),
                              ],
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          right: 15,
                          top: 15,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditPage(
                                            postMedia: profileDetailModel
                                                    ?.profile?.profilePicture ??
                                                '',
                                          )));
                            },
                            child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(color: AppColor.BUTTON_COLOR),
                              ),
                              child: Image.asset(
                                Assets.icEditProfile,
                                height: 35,
                                width: 35,
                              ),
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  tabOptions(_names, logoOne),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            )
          : circularIndicator(context),
    );
  }

  shareIconView(String image, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        width: 35,
        padding: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppColor.BACKGROUND_COLOR.withOpacity(0.5)),
        child: Image.asset(
          image,
          height: 25,
          width: 25,
        ),
      ),
    );
  }

  void onItemSelection(BuildContext context, int index) {
    if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BudiAppBalance()));
    } else if (index == 5) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NotificationPage()));
    } else if (index == 6) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => InviteFriends()));
    } else if (index == 8) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyReviews()));
    } else if (index == 13) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TermsOfService()));
    } else if (index == 14) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Settings()));
    } else if (index == 15) {
      logOutPressed();
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

  tabOptions(List<String> names, List<String> logo) {
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
                  index == 4 || index == 10 || index == 13
                      ? Container(
                          height: 5,
                          width: MediaQuery.of(context).size.width,
                          color: AppColor.OFF_WHITE_COLOR,
                        )
                      : SizedBox(),
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
                                      color: index == 15
                                          ? AppColor.RED_COLOR
                                          : AppColor.GOOGLETEXT_COLOR,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Icon(
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

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  logOutPressed() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('LogInToken');
      var params = {"": ""};
      AppIndicator.loadingIndicator();
      final url = Uri.parse('http://74.208.150.111/api/logout');
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
}
