import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class InviteFriends extends StatefulWidget {
  const InviteFriends({Key? key}) : super(key: key);

  @override
  State<InviteFriends> createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  List<String> social = [
    Assets.icCopy,
    Assets.icWhatsapp,
    Assets.icTelegram,
    Assets.icMessenger
  ];

  List<String> socialTwo = [
    Assets.icTwitter,
    Assets.icFacbook,
    Assets.icInsta,
    Assets.icCitrix,
  ];

  List<String> socialName = ['Copy', 'WhatsApp', 'Telegram', 'Messenger'];

  List<String> socialNameTwo = ['Twitter', 'Facebook', 'Instagram', 'Citrix'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              msg: 'Invite friends',
              color: Colors.white,
              fontSize: 16,
            )),
      ),
      backgroundColor: AppColor.OFF_WHITE_COLOR,
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getBoldText(
                msg: 'Invite a friend and get bonus!',
                fontSize: 16,
                color: AppColor.SIGNIN_COLOR),
            SizedBox(
              height: 8,
            ),
            getRegularStyleText(
                msg:
                    'Recommend BUDI to your friends and earn up to 100. For every \nfriends who makes their first purchase, you’ll receive 20!',
                fontSize: 10,
                color: AppColor.SIGNIN_COLOR),
            SizedBox(
              height: 60,
            ),
            shareSocial('Send the link to your friend', social, socialName),
            SizedBox(
              height: 60,
            ),
            shareSocial('Share on Social Media', socialTwo, socialNameTwo),
            SizedBox(
              height: 60,
            ),
            sharePersonal()
          ],
        ),
      ),
    );
  }

  shareSocial(
    String title,
    List<String> social,
    List<String> socialName,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getBoldText(msg: title, fontSize: 16, color: AppColor.SIGNIN_COLOR),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 80,
          child: ListView.builder(
              itemCount: social.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: index == 1
                                ? Colors.transparent
                                : index == 2
                                    ? AppColor.TELEGRAM_COLOR
                                    : AppColor.TEXT_COLOR.withOpacity(0.4)),
                        margin: EdgeInsets.only(left: 5),
                        height: 60,
                        width: 60,
                        child: Image.asset(social[index])),
                    getRegularStyleText(
                        msg: socialName[index],
                        fontSize: 12,
                        color: AppColor.TEXT_COLOR)
                  ],
                );
              }),
        ),
      ],
    );
  }

  sharePersonal() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getBoldText(msg: 'Invites ( 40 earned)', fontSize: 16, color: AppColor.SIGNIN_COLOR),
            getBoldText(msg: '5 Pending', fontSize: 12, color: AppColor.LABLE_COLOR),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: 80,
          child: ListView.builder(
              itemCount: 15,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                        child: CircleAvatar(
                          backgroundColor: Colors.greenAccent[400],
                          radius: 26,
                          child: Image.asset(
                              'assets/images/ic_sharePerson.png'), //Text
                        )),
                    SizedBox(height: 8,),
                    getRegularStyleText(
                        msg:'Name',
                        fontSize: 12,
                        color: AppColor.TEXT_COLOR)
                  ],
                );
              }),
        ),
      ],
    );
  }
}
