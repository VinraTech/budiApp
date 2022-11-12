import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/HomePageItems/HotelCheckOut.dart';
import 'package:budi/HomePageItems/HotelsDetailPage.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class HotelTabDetails extends StatefulWidget {
  const HotelTabDetails({Key? key}) : super(key: key);

  @override
  State<HotelTabDetails> createState() => _HotelTabDetailsState();
}

class _HotelTabDetailsState extends State<HotelTabDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topViewDescription(),
          // AppButton(
          //   width: MediaQuery.of(context).size.width,
          //   height: 55,
          //   color: AppColor.BUTTON_COLOR,
          //   label: 'Book Now',
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => HotelCheckOut()));
          //   },
          // ),
        ],
      ),
    );
  }

  topViewDescription() {
    return Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          getSemiBoldText(
              msg: 'Description', color: AppColor.SIGNIN_COLOR, fontSize: 16),
          SizedBox(
            height: 15,
          ),
          getRegularStyleText(
              msg:
                  'At the Selina Bogota Hotel, enjoy the beautiful views of city\n life in downtown Bogota while relaxing in the plush luxury\n suites that this hotel has to offer.',
              fontSize: 12,
              color: AppColor.SIGNIN_COLOR),
          SizedBox(
            height: 15,
          ),
          getRegularStyleText(
              msg:
                  'This luxuriously designed hotel with its slick style and\n modern amenities, is situated in the heart of the capital.\n So if youre looking to enjoy all that the city has to offer, this hotel should be at the top of your list.',
              fontSize: 12,
              color: AppColor.SIGNIN_COLOR),
          SizedBox(
            height: 25,
          ),
          getSemiBoldText(
              msg: 'Location', color: AppColor.SIGNIN_COLOR, fontSize: 16),
          SizedBox(
            height: 15,
          ),
          Image.asset('assets/images/ic_mapTwo.png'),
        ]));
  }
}
