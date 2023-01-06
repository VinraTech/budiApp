import 'dart:convert';
import 'package:budi/AgentSection/CreateOfferPage.dart';
import 'package:budi/Chat/ChatList.dart';
import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/Common%20Fields/CircularIndicator.dart';
import 'package:budi/Models/ProfileDetailModel.dart';
import 'package:budi/ProfilePageItems/ContactUs.dart';
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
  String? userEmail, roleType;

  final List<String> _names = [
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

  List<String> userlogo = [
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

  List<String> agentProfileItemNames = [
    'Add Budi Trip Offering',
    'Agent Package List',
    'Deals of the Day',
    'Unique Services offered',
    'Notification',
    'Help',
    'Contact Us',
    'Settings',
    'Terms & Condition',
  ];

  List<String> agentlogo = [
    Assets.icIntrest,
    Assets.icReviews,
    Assets.icUmbrella,
    Assets.ic_EmailIcon,
    Assets.icNotification,
    Assets.icIntrest,
    Assets.icBag,
    Assets.icSetting,
    Assets.icArticle,
  ];

  Future<void> getProfileDetails() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('LogInToken');
      final res = await http
          .get(Uri.parse("http://74.208.150.111/api/profile/show"), headers: {
        'Authorization': 'Bearer $token',
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

  getLoggedInUserDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userEmail = sharedPreferences.getString('userEmail');
    roleType = sharedPreferences.getString('roles');
  }

  @override
  void initState() {
    getLoggedInUserDetails();
    getProfileDetails();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      resizeToAvoidBottomInset: false,
      floatingActionButton: roleType == 'user' || roleType == null
          ? SizedBox()
          : Container(
              child: FloatingActionButton(
                elevation: 1,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateOferPage()));
                },
                backgroundColor: AppColor.BUTTON_COLOR,
                child: Icon(Icons.add),
              ),
            ),
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
      body: profileDetailModel != null && roleType != null && userEmail != null
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 25),
                        width: MediaQuery.of(context).size.width,
                        height: roleType == 'user' ? 220 : 305,
                        color: Colors.white,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: roleType == 'user' ? 50 : 38,
                              backgroundImage: NetworkImage(
                                  profileDetailModel?.profile?.profilePicture ??
                                      ''),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              profileDetailModel?.profile?.user?.name ?? '',
                              style: const TextStyle(
                                  color: AppColor.SIGNIN_COLOR, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            roleType == 'user'
                                ? SizedBox()
                                : Text(
                                    userEmail ?? '',
                                    style: const TextStyle(
                                        color: AppColor.SIGNIN_COLOR,
                                        fontSize: 16),
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            roleType == 'user'
                                ? SizedBox()
                                : messageAndDashboardButton(),
                            const SizedBox(
                              height: 10,
                            ),
                            roleType == 'user'
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      shareIconView(Assets.icinstagramIcon, () {
                                        _launchURL(profileDetailModel
                                                ?.profile?.instagramHandle ??
                                            ' ');
                                      }),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      shareIconView(Assets.icTikTokIcon, () {
                                        _launchURL(profileDetailModel
                                                ?.profile?.tiktokHandle ??
                                            ' ');
                                      }),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      shareIconView(Assets.icBlackFacebookIcon,
                                          () {
                                        _launchURL(profileDetailModel
                                                ?.profile?.facebookHandle ??
                                            ' ');
                                      }),
                                    ],
                                  )
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      boxView('17', 'projects', 20),
                                      boxView('6', 'Offers', 20),
                                      boxView('100+', ' completed', 20),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                      Positioned(
                          right: 15,
                          top: 15,
                          child: roleType == 'user'
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditPage(
                                                  postMedia: profileDetailModel
                                                          ?.profile
                                                          ?.profilePicture ??
                                                      '',
                                                ))).then((value) {
                                      getProfileDetails();
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: AppColor.BUTTON_COLOR),
                                    ),
                                    child: Image.asset(
                                      Assets.icEditProfile,
                                      height: 35,
                                      width: 35,
                                    ),
                                  ),
                                )
                              : SizedBox())
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  roleType == 'user'
                      ? tabOptions(_names, userlogo)
                      : tabOptions(agentProfileItemNames, agentlogo),
                  const SizedBox(
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
        padding: const EdgeInsets.all(6.0),
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

  void onUserItemSelection(BuildContext context, int index) {
    if (index == 0) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const BudiAppBalance()));
    } else if (index == 5) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NotificationPage()));
    } else if (index == 6) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const InviteFriends()));
    } else if (index == 8) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyReviews()));
    } else if (index == 13) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TermsOfService(
                    title: 'Terms of service',
                    pageType: 'terms',
                  )));
    } else if (index == 14) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Settings()));
    } else if (index == 15) {
      logOutPressed();
    }
  }

  void onAgentItemSelection(BuildContext context, int index) {
    if (index == 0) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CreateOferPage()));
    } else if (index == 4) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NotificationPage()));
    } else if (index == 5) {
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => const InviteFriends()));
    } else if (index == 6) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const ContactUs()));
    } else if (index == 7) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Settings()));
    } else if (index == 8) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TermsOfService(
                    title: 'Terms of service',
                    pageType: 'terms',
                  )));
    }
  }

  tabOptions(List<String> names, List<String> logo) {
    return Container(
      padding: roleType == 'user'
          ? EdgeInsets.only(bottom: 0)
          : EdgeInsets.only(bottom: 70),
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
                roleType == 'user'
                    ? onUserItemSelection(context, index)
                    : onAgentItemSelection(context, index);
              },
              child: Column(
                children: [
                  index == 4 || index == 10 || index == 13
                      ? Container(
                          height: 5,
                          width: MediaQuery.of(context).size.width,
                          color: AppColor.OFF_WHITE_COLOR,
                        )
                      : const SizedBox(),
                  Container(
                      margin: const EdgeInsets.only(left: 18, right: 15),
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
                                  style: TextStyle(
                                      color: index == 15
                                          ? AppColor.RED_COLOR
                                          : AppColor.GOOGLETEXT_COLOR,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
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

  boxView(String msg, String msg2, double fontSize) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.OFF_WHITE_COLOR),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getBoldText(
                  msg: msg, fontSize: fontSize, color: AppColor.SIGNIN_COLOR),
              getRegularStyleText(
                msg: msg2,
                fontSize: 14,
                color: AppColor.SIGNIN_COLOR,
              ),
            ],
          ),
        )
      ],
    );
  }

  messageAndDashboardButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppButton(
          width: MediaQuery.of(context).size.width / 2.8,
          height: 45,
          color: Colors.white,
          label: 'Dashboard',
          lableColor: AppColor.BUTTON_COLOR,
          onTap: () {},
        ),
        AppButton(
          width: MediaQuery.of(context).size.width / 2.8,
          height: 45,
          color: Colors.white,
          lableColor: AppColor.BUTTON_COLOR,
          label: 'Messages',
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ChatList()));
          },
        )
      ],
    );
  }
}
