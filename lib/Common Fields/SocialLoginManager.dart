import 'dart:io';
import 'package:budi/Helpers/AppIndicator.dart';
import 'package:budi/Helpers/ToastMessage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


Map<String, dynamic>? _userData;
bool isGoogle = false;
GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
);

class SocialLoginManager {
  static Future<void> handleSignOut() => _googleSignIn.disconnect();

  static Future<void> loginWithGoogle(BuildContext context) async {
    try {
      await FirebaseMessaging.instance.getToken().then((value) {
        _googleSignIn.signIn().then((userData) {
          userData!.authentication.then((googleKey) {
            print(googleKey.accessToken);
            print(googleKey.idToken);
            print(_googleSignIn.currentUser!.displayName);
            socialLoginPressed(
                context,
                userData.id,
                googleKey.accessToken!,
                value ?? "",
                Platform.isAndroid ? "Android" : "Ios",
                "Google",
                _googleSignIn.currentUser!.email,
                _googleSignIn.currentUser!.displayName!);
          }).catchError((err) {
            print('inner error');
          });
        }).catchError((err) {
          print('error occurred');
        });
      });
    } catch (error) {
      ToastMessage.message(error.toString());
      print(error);
    }
  }

  // static Future<void> loginWithFB(
  //     BuildContext context, StateSetter setState) async {
  //   AccessToken? _accessToken;
  //   await FirebaseMessaging.instance.getToken().then((value) {
  //     FacebookAuth.instance.logOut();
  //     FacebookAuth.instance.login().then((result) async {
  //       if (result.status == LoginStatus.success) {
  //         _accessToken = result.accessToken;
  //         final userData = await FacebookAuth.instance.getUserData();
  //         _userData = userData;
  //         socialLoginPressed(
  //           context,
  //           _accessToken!.userId,
  //           _accessToken!.token,
  //           value ?? "",
  //           Platform.isAndroid ? "Android" : "Ios",
  //           "Facebook",
  //           userData['email'] != null ? userData['email'] : '',
  //           userData['name'],
  //         );
  //       } else {
  //         print(result.status);
  //         print(result.message);
  //       }
  //       setState(() {});
  //     });
  //   });
  // }

  // static Future<void> loginWithApple(BuildContext context) async {
  //   await FirebaseMessaging.instance.getToken().then((value) async {
  //     final credential = await SignInWithApple.getAppleIDCredential(scopes: [
  //       AppleIDAuthorizationScopes.email,
  //       AppleIDAuthorizationScopes.fullName
  //     ]);
  //     var lastName =
  //         credential.familyName != null ? (" " + credential.familyName!) : "";
  //     if (credential.email == null) {
  //       socialLoginPressed(context, credential.userIdentifier!,
  //           credential.identityToken!, value ?? "", "Ios", "apple", '', '');
  //     } else {
  //       socialLoginPressed(
  //         context,
  //         credential.userIdentifier ?? "",
  //         credential.identityToken ?? "",
  //         value ?? "",
  //         Platform.isAndroid ? "Android" : "Ios",
  //         "apple",
  //         credential.email ?? "",
  //         credential.givenName ?? "" + lastName,
  //
  //       );
  //     }
  //   });
  // }

  static socialLoginPressed(
    context,
    String socialID,
    String accessToken,
    String deviceToken,
    String deviceType,
    String provider,
    String userEmail,
    String userName,
  ) async {
    AppIndicator.loadingIndicator();
    // AppNetworkManager.loginWithSocialMedia(
    //     socialID,
    //     accessToken,
    //     provider,
    //     deviceToken,
    //     deviceType,
    //     userEmail,
    //     userName,
    //     context, (result, isSuccess) {
    //   if (isSuccess) {
    //     UserInfoModel? userInfoModel;
    //     userInfoModel =
    //         ((result as SuccessState).value as ASResponseModal).dataModal;
    //     if (userInfoModel!.userInformation!.first_time_social == false) {
    //       // if(userInfoModel.userInformation?.isApproved == true){
    //         AppDataManager.getInstance.updateUserDetails(userInfoModel);
    //         navigationPushAndRemoveUntil(context, BottomNavigation());
    //       // }else{
    //       //   navigationPushAndRemoveUntil(
    //       //       context,
    //       //       WelcomeScreen(
    //       //         userName: userInfoModel.userInformation?.firstName,
    //       //         userStatus: userInfoModel.userInformation?.isApproved,
    //       //       ));
    //       // }
    //     }
    //     else {
    //       if (provider == "Google") {
    //         showDialog(
    //             context: context,
    //             builder: (BuildContext context) => SocialLoginUpdate(
    //                   userEmail: userInfoModel?.userInformation?.email,
    //                   userId: userInfoModel!.userInformation!.userId,
    //               isSocial: userInfoModel.userInformation!.is_social,
    //                 ));
    //       } else if (provider == "Facebook") {
    //         showDialog(
    //             context: context,
    //             builder: (BuildContext context) => SocialLoginUpdate(
    //                   userEmail: userInfoModel?.userInformation?.email,
    //                   userId: userInfoModel!.userInformation!.userId,
    //               isSocial: userInfoModel.userInformation!.is_social,
    //                 ));
    //       } else if (provider == "apple") {
    //         showDialog(
    //             context: context,
    //             builder: (BuildContext context) => SocialLoginUpdate(
    //                   userEmail: userInfoModel?.userInformation?.email,
    //                   userId: userInfoModel!.userInformation!.userId.toString(),
    //               isSocial: userInfoModel.userInformation!.is_social,
    //                 ));
    //       }
    //     }
    //   }
    // });
  }
}
