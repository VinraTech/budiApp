import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class HotelFeatures extends StatefulWidget {
  const HotelFeatures({Key? key}) : super(key: key);

  @override
  State<HotelFeatures> createState() => _HotelFeaturesState();
}

class _HotelFeaturesState extends State<HotelFeatures> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20,),
          Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
              child: GridView.builder(
                itemCount: 12,
                padding: const EdgeInsets.all(0.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 70 / 70,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => HotelsDetailPage()));
                    },
                    child: Container(
                      width: 163,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),color: Colors.transparent),
                      child: Column(
                        children: [
                          Image.asset('assets/images/ic_HotelFeatures.png',height: 50,width: 50,),
                          SizedBox(
                            height: 6,
                          ),
                          getRegularStyleText(msg: '04 Rooms',color: AppColor.SIGNIN_COLOR,fontSize: 10),
                        ],
                      ),
                    ),
                  );
                },
              )),
          // AppButton(
          //   width: MediaQuery.of(context).size.width,
          //   height: 55,
          //   color: AppColor.BUTTON_COLOR,
          //   label: 'Book Now',
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => HotelCheckOut()));
          //   },
          // ),
        ],
      ),
    );
  }
}
