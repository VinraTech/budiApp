import 'package:budi/Common%20Fields/AppDailogBox.dart';
import 'package:budi/HomePageItems/CarDetails.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class RentCar extends StatefulWidget {
  const RentCar({Key? key}) : super(key: key);

  @override
  State<RentCar> createState() => _RentCarState();
}

class _RentCarState extends State<RentCar> {
  List<String> brandImage = [
    'assets/images/ic_audi.png',
    'assets/images/ic_tesla.png',
    'assets/images/ic_ford.png',
    'assets/images/ic_hyundai.png'
  ];

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
              msg: 'Cars For Rentals',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getSemiBoldText(
                  msg: 'Brands', fontSize: 18, color: AppColor.SIGNIN_COLOR),
              SizedBox(
                width: 20,
              ),
              Container(
                height: 50,
                child: ListView.builder(
                    itemCount: brandImage.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 70,
                        padding: EdgeInsets.only(left: 7, right: 7),
                        margin: EdgeInsets.only(right: 6, left: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.BACKGROUND_COLOR,
                            border: Border.all(
                                width: 1, color: AppColor.TEXT_COLOR)),
                        child: Image.asset(
                          brandImage[index],
                          height: 30,
                          width: 30,
                        ),
                      );
                    }),
              ),
              SizedBox(
                width: 20,
              ),
              getSemiBoldText(
                  msg: 'Available Cars',
                  fontSize: 18,
                  color: AppColor.SIGNIN_COLOR),
              SizedBox(
                width: 20,
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.96,
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
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
                        onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CarDetails()));
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
                                Image.asset('assets/images/ic_car.png'),
                                SizedBox(
                                  height: 6,
                                ),
                                getRegularStyleText(
                                    msg: 'Land Rover Discovery',
                                    color: AppColor.SIGNIN_COLOR,
                                    fontSize: 14),
                                SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                            '120', 12, AppColor.BUTTON_COLOR),
                                        textView(
                                            '/Day', 12, AppColor.TEXT_COLOR)
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
            ],
          ),
        ),
      ),
    );
  }
}
