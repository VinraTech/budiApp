import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class TabOffers extends StatefulWidget {
  const TabOffers({Key? key}) : super(key: key);

  @override
  State<TabOffers> createState() => _TabOffersState();
}

class _TabOffersState extends State<TabOffers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        height: 600,
        child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return Card(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/ic_Image.png',
                      height: 110,
                      width: 110,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          getSemiBoldText(
                              msg: 'Best trip ever!',
                              fontSize: 14,
                              color: AppColor.SIGNIN_COLOR),
                          SizedBox(
                            height: 10,
                          ),
                          getRegularStyleText(
                              msg:
                                  'Come along on this amazing hike of\n Nevado Santa Isabel and enjoy the\n crunching of snow underfoot as we\n make our way to the top!',
                              textAlign: TextAlign.left,
                              fontSize: 10),
                          SizedBox(
                            height: 10,
                          ),
                          getRegularStyleText(
                              msg: '100',
                              fontSize: 14,
                              color: AppColor.DARKBLUE),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
