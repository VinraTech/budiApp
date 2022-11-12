import 'package:budi/Chat/ChatPage.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
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
              msg: 'Messages',
              color: Colors.white,
              fontSize: 16,
            )),
        actions: [
          Image.asset(Assets.icFilter),
          Image.asset(
            Assets.ic_Search,
            color: Colors.white,
            height: 20,
            width: 20,
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 15, right: 15),
        child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatPage()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Container(
                        child: CircleAvatar(
                          backgroundColor: Colors.greenAccent[400],
                          radius: 26,
                          child: Image.asset(
                              'assets/images/ic_carRenter.png'), //Text
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                getSemiBoldText(
                                    msg: 'Wade Waren',
                                    fontSize: 16,
                                    color: AppColor.SIGNIN_COLOR),
                                getSemiBoldText(
                                    msg: 'May 22',
                                    fontSize: 12,
                                    color: AppColor.TEXT_COLOR),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: getSemiBoldText(
                                msg:
                                    'Testing a verifying staging build for tickets ',
                                fontSize: 12,
                                color: AppColor.TEXT_COLOR),
                          )
                        ],
                      )
                      // Expanded(
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       getSemiBoldText(
                      //           msg: 'Wade Waren',
                      //           fontSize: 16,
                      //           color: AppColor.SIGNIN_COLOR),
                      //       getSemiBoldText(
                      //           msg: 'May 22',
                      //           fontSize: 12,
                      //           color: AppColor.TEXT_COLOR),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
