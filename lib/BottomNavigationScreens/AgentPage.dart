import 'package:budi/Chat/ChatList.dart';
import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class AgentPage extends StatefulWidget {
  const AgentPage({Key? key}) : super(key: key);

  @override
  State<AgentPage> createState() => _AgentPageState();
}

class _AgentPageState extends State<AgentPage> {
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
              msg: 'Agent Name',
              color: Colors.white,
              fontSize: 16,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: 350,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(15)),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Image.asset(
                          'assets/images/ic_agentOffer.png',
                          fit: BoxFit.fill,
                          width: 330,
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            getSemiBoldText(
                msg: 'Offers', color: AppColor.HOMETEXT, fontSize: 16),
            SizedBox(
              height: 20,
            ),
            getSemiBoldText(
                msg: 'Daily', color: AppColor.LABLE_COLOR, fontSize: 30),
            SizedBox(
              height: 20,
            ),
            getRegularStyleText(
                msg:
                    'Malesuada cras lorem netus pulvinar \nturpis neque. Aliquam mi, enim ornare pharetra. \nFaucibus tempor faucibus vitae commodo rutrum \npulvinar consectetur',
                fontSize: 14,
                color: AppColor.TEXT_COLOR,
                textAlign: TextAlign.center),
            SizedBox(
              height: 60,
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      // <-- SEE HERE
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    builder: (context) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                          color: AppColor.HOMETEXT,
                        ),
                        height: 350,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(height: 10),
                            Container(
                              alignment: Alignment.center,
                              height: 10,
                              padding: EdgeInsets.all(60),
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: AppColor.TEXT_COLOR,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                boxView('17', 'projects', 20),
                                boxView('6', 'Offers', 20),
                                boxView('100+', ' completed', 20),
                              ],
                            ),
                            SizedBox(height: 20),
                            hotelSummary(),
                            SizedBox(height: 20),
                            AppButton(
                              width: MediaQuery.of(context).size.width,
                              height: 55,
                              color: AppColor.BUTTON_COLOR,
                              label: 'View Profile',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatList()));
                              },
                            )
                          ],
                        ),
                      );
                    });
              },
              child: Container(
                alignment: Alignment.center,
                height: 10,
                padding: EdgeInsets.all(60),
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: AppColor.TEXT_COLOR,
                ),
              ),
            )
          ],
        ),
      ),
    );
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

  hotelSummary() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white,),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/ic_bg.png',
                height: 120,
                width: 120,
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getRegularStyleText(
                      msg: 'Beach tour LA',
                      fontSize: 16,
                      color: AppColor.SIGNIN_COLOR),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     starIcon(Icons.star, 12),
                  //     starIcon(Icons.star, 12),
                  //     starIcon(Icons.star, 12),
                  //     starIcon(Icons.star, 12),
                  //     starIcon(Icons.star, 12),
                  //   ],
                  // ),
                  getRegularStyleText(
                      msg: 'Morbi augue molestie viverra \nullamcorper',
                      fontSize: 12,
                      color: AppColor.TEXT_COLOR),
                  SizedBox(height: 10,),
                  getRegularStyleText(
                      msg: '320',
                      fontSize: 16,
                      color: AppColor.BUTTON_COLOR),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
