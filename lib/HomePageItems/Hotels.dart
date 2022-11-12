import 'package:budi/Common%20Fields/AppDailogBox.dart';
import 'package:budi/HomePageItems/HotelsDetailPage.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class Hotels extends StatefulWidget {
  const Hotels({Key? key}) : super(key: key);

  @override
  State<Hotels> createState() => _HotelsState();
}

class _HotelsState extends State<Hotels> {
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
              msg: 'Available hotels',
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
          height: MediaQuery.of(context).size.height * 0.96,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
          child: GridView.builder(
            itemCount: 20,
            padding: const EdgeInsets.all(0.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 153 / 170,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HotelsDetailPage()));
                },
                child: Container(
                  width: 163,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25)),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/images/ic_hotels.png'),
                        SizedBox(
                          height: 6,
                        ),
                        getRegularStyleText(msg: 'Selina Bogota Hotel',color: AppColor.SIGNIN_COLOR,fontSize: 14),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                starIcon(Icons.star, 12),
                                starIcon(Icons.star, 12),
                                starIcon(Icons.star, 12),
                                starIcon(Icons.star, 12),
                                starIcon(Icons.star, 12),
                              ],
                            ),
                            Row(
                              children: [
                                textView(
                                    '150',
                                    12,
                                    AppColor.BUTTON_COLOR),
                                textView(
                                    '/Night',
                                    12,
                                    AppColor.TEXT_COLOR)
                              ],
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              );
              ;
            },
          )),
    );
  }
}
