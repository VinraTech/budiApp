import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/Common%20Fields/AppDailogBox.dart';
import 'package:budi/HomePageItems/CheckOutPayment.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class HotelCheckOut extends StatefulWidget {
  bool? carRent;
  String? image;

  HotelCheckOut({Key? key, this.carRent, this.image}) : super(key: key);

  @override
  State<HotelCheckOut> createState() => _HotelCheckOutState();
}

class _HotelCheckOutState extends State<HotelCheckOut> {
  bool isCheckIn = false;
  bool isCheckOut = false;
  bool isGuest = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: AppButton(
          width: MediaQuery.of(context).size.width,
          height: 55,
          color: AppColor.BUTTON_COLOR,
          label: 'Checkout',
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CheckOutPayment(carRent: widget.carRent,)));
          },
        ),
      ),
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
              msg: 'Details',
              color: Colors.white,
              fontSize: 16,
            )),
      ),
      backgroundColor: AppColor.OFF_WHITE_COLOR,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hotelSummary(),
              SizedBox(
                height: 15,
              ),
              checkIn(),
              SizedBox(
                height: 15,
              ),
              checkOut(),
              SizedBox(
                height: 15,
              ),
              widget.carRent == true ? SizedBox() : guest(),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  hotelSummary() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          getSemiBoldText(
              msg: widget.carRent == true ? 'Rental Summary' : 'Hotel Summary',
              fontSize: 16,
              color: AppColor.SIGNIN_COLOR),
          SizedBox(
            height: 10,
          ),
          getRegularStyleText(
              msg:
              widget.carRent == true
                  ? 'Prices may change depending on the length of the \nrental and the price of your rental car.':'Come enjoy your stay with us and see why our\n guests rate us number 1 in service and style',
              fontSize: 12,
              color: AppColor.TEXT_COLOR),
          Row(
            children: [
              Image.asset(
                widget.carRent == true
                    ? 'assets/images/ic_car.png':'assets/images/ic_bg.png',
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
                  getSemiBoldText(
                      msg:  widget.carRent == true
                          ? 'Audi X12'
                          : 'The Selina Bogota Hotel',
                      fontSize: 16,
                      color: AppColor.SIGNIN_COLOR),
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
                  getRegularStyleText(
                      msg: '440+ Reviewer',
                      color: AppColor.SIGNIN_COLOR,
                      fontSize: 14)
                ],
              )
            ],
          ),
          Divider(
            color: AppColor.TEXT_COLOR,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getRegularStyleText(
                  msg: widget.carRent == true ? 'Rent/Day' : 'Book/day',
                  color: AppColor.TEXT_COLOR),
              getSemiBoldText(msg: '80', color: AppColor.HOMETEXT)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getRegularStyleText(msg: 'Tax', color: AppColor.TEXT_COLOR),
              getSemiBoldText(msg: '0', color: AppColor.HOMETEXT)
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            color: AppColor.SHADOW_COLOR,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 6),
                  width: MediaQuery.of(context).size.width / 1.6,
                  color: AppColor.SHADOW_COLOR,
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Apply Promo Code',
                        hintStyle: TextStyle(fontSize: 12)),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 4.1,
                  color: AppColor.SHADOW_COLOR,
                  child: getSemiBoldText(msg: 'Apply Now', fontSize: 12),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  checkIn() {
    return Container(
      padding: EdgeInsets.only(left: 20),
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isCheckIn = !isCheckIn;
                    });
                  },
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: isCheckIn == true
                                ? AppColor.TEXT_COLOR
                                : AppColor.SIGNIN_COLOR),
                        color: isCheckIn == true
                            ? AppColor.SIGNIN_COLOR
                            : AppColor.SHADOW_COLOR),
                  ),
                ),
                getSemiBoldText(
                    msg: widget.carRent == true ? 'pick-up' : 'Check In',
                    fontSize: 16,
                    color: AppColor.SIGNIN_COLOR),
                Container(
                  height: 30,
                  width: 30,
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: AppColor.BUTTON_COLOR),
                  child: Image.asset('assets/images/ic_calender.png'),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              widget.carRent == true
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getSemiBoldText(
                            msg: 'Location',
                            fontSize: 16,
                            color: AppColor.SIGNIN_COLOR),
                        SizedBox(
                                height: 5,
                              ),
                        Row(
                          children: [
                            getRegularStyleText(msg: 'Semarang', fontSize: 12),
                            SizedBox(
                              width: 5,
                            ),
                            Image.asset(
                              'assets/images/ic_down.png',
                              height: 15,
                              width: 15,
                            )
                          ],
                        )
                      ],
                    ): SizedBox(),
              widget.carRent == true
                  ? SizedBox(
                      width: 15,
                    ): SizedBox(),
              widget.carRent == true
                  ?
                  Container(
                      height: 40,
                      width: 2,
                      color: AppColor.TEXT_COLOR,
                    ) : SizedBox(),
              SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getSemiBoldText(msg: 'Date'),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      getRegularStyleText(msg: '20 July 2022', fontSize: 12),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        'assets/images/ic_down.png',
                        height: 15,
                        width: 15,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                height: 40,
                width: 2,
                color: AppColor.TEXT_COLOR,
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getSemiBoldText(msg: 'Time'),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      getRegularStyleText(msg: '20 July 2022', fontSize: 12),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        'assets/images/ic_down.png',
                        height: 15,
                        width: 15,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  checkOut() {
    return Container(
      padding: EdgeInsets.only(left: 20),
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isCheckOut = !isCheckOut;
                    });
                  },
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: isCheckOut == true
                                ? AppColor.TEXT_COLOR
                                : AppColor.SIGNIN_COLOR),
                        color: isCheckOut == true
                            ? AppColor.SIGNIN_COLOR
                            : AppColor.SHADOW_COLOR),
                  ),
                ),
                getSemiBoldText(
                    msg: widget.carRent == true ? 'drop-off' : 'Check Out',
                    fontSize: 16,
                    color: AppColor.SIGNIN_COLOR),
                Container(
                  height: 30,
                  width: 30,
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: AppColor.BUTTON_COLOR),
                  child: Image.asset('assets/images/ic_calender.png'),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              widget.carRent == true
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getSemiBoldText(
                      msg: 'Location',
                      fontSize: 16,
                      color: AppColor.SIGNIN_COLOR),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      getRegularStyleText(msg: 'Semarang', fontSize: 12),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        'assets/images/ic_down.png',
                        height: 15,
                        width: 15,
                      )
                    ],
                  )
                ],
              ): SizedBox(),
              widget.carRent == true
                  ? SizedBox(
                width: 15,
              ): SizedBox(),
              widget.carRent == true
                  ?
              Container(
                height: 40,
                width: 2,
                color: AppColor.TEXT_COLOR,
              ) : SizedBox(),
              SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getSemiBoldText(msg: 'Date'),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      getRegularStyleText(msg: '20 July 2022', fontSize: 12),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        'assets/images/ic_down.png',
                        height: 15,
                        width: 15,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                height: 40,
                width: 2,
                color: AppColor.TEXT_COLOR,
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getSemiBoldText(msg: 'Time'),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      getRegularStyleText(msg: '20 July 2022', fontSize: 12),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        'assets/images/ic_down.png',
                        height: 15,
                        width: 15,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  guest() {
    return Container(
      padding: EdgeInsets.only(left: 20),
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isGuest = !isGuest;
                    });
                  },
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: isGuest == true
                                ? AppColor.TEXT_COLOR
                                : AppColor.SIGNIN_COLOR),
                        color: isGuest == true
                            ? AppColor.SIGNIN_COLOR
                            : AppColor.SHADOW_COLOR),
                  ),
                ),
                getSemiBoldText(
                    msg: 'Guest', fontSize: 16, color: AppColor.SIGNIN_COLOR),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getSemiBoldText(msg: 'Adults'),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      getRegularStyleText(msg: '3'),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        'assets/images/ic_down.png',
                        height: 15,
                        width: 15,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                height: 40,
                width: 2,
                color: AppColor.TEXT_COLOR,
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getSemiBoldText(msg: 'Children'),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      getRegularStyleText(msg: '1'),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        'assets/images/ic_down.png',
                        height: 15,
                        width: 15,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
