import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
                msg: 'Jane Cooper',
                color: Colors.white,
                fontSize: 16,
              )),
        ),
        body: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 15, right: 15),
            child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: receivedMessage(),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerRight,
                        child: sendMessage(),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  );
                }),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/ic_smiley.png',
                    height: 25,
                    width: 25,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColor.TEXT_COLOR.withOpacity(0.4)),
                    padding: EdgeInsets.only(left: 15),
                    width: MediaQuery.of(context).size.width * 0.87,
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type Your Message',
                          suffixIcon: Container(
                            padding: EdgeInsets.all(8),
                            child: Image.asset(
                              'assets/images/ic_sendButton.png',
                              height: 10,
                              width: 10,
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
          )
        ]));
  }

  receivedMessage() {
    return Container(
      height: 60,
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(6),
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25)),
        color: Colors.grey.withOpacity(0.6),
      ),
      child: getRegularStyleText(
          msg: 'Will it last long?', fontSize: 14, color: AppColor.HOMETEXT),
    );
  }

  sendMessage() {
    return Container(
      height: 60,
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(6),
            topLeft: Radius.circular(25),
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25)),
        color: AppColor.BACKGROUND_COLOR.withOpacity(0.6),
      ),
      child: getRegularStyleText(
          msg: 'Will it last long?', fontSize: 14, color: AppColor.HOMETEXT),
    );
  }
}
