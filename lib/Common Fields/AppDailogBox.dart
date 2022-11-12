import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:flutter/material.dart';

var alert;

offerDialogue(BuildContext context, {required VoidCallback onTap}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      // content: Column(
      //     children: [
      //
      // ]),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Get huge discounts on you trips \nthis fall',
                  style: TextStyle(fontSize: 16, color: AppColor.SIGNIN_COLOR)),
              Text('50% off',
                  style: TextStyle(fontSize: 20, color: AppColor.SIGNIN_COLOR)),
              Text('offer ends November 30, 2022',
                  style: TextStyle(fontSize: 12, color: AppColor.TEXT_COLOR)),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 200,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Card(
                          elevation: 3,
                          child: Stack(
                            children: [
                              Image.asset(
                                Assets.icDemoTwo,
                                fit: BoxFit.fill,
                                width: 330,
                              ),
                              Positioned(
                                  bottom: 0,
                                  child: Container(
                                    height: 80,
                                    padding: EdgeInsets.only(left: 10, right: 30),
                                    width: MediaQuery.of(context).size.width - 110,
                                    color: AppColor.SIGNIN_COLOR.withOpacity(0.4),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            textView('Awesome trip', 16, Colors.white),
                                            Row(
                                              children: [
                                                textView('Sed ut perspiciatis ', 14,
                                                    Colors.white),
                                                Image.asset(
                                                  Assets.icVerified,
                                                  height: 14,
                                                  width: 14,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            starIcon(Icons.star, 22),
                                            textView('4.8', 18, Colors.white),
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      );
                    }),


                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(15)),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: AppButton(
                  width: MediaQuery.of(context).size.width / 2.6,
                  height: 55,
                  color: AppColor.BUTTON_COLOR,
                  label: 'Redeem',
                  onTap: onTap,
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

textView(String lable, double fontSize, Color colors) {
  return Text(
    lable,
    style: TextStyle(color: colors, fontSize: fontSize),
    textAlign: TextAlign.center,
  );
}

starIcon(IconData star, double size) {
  return Icon(
    Icons.star,
    color: Colors.amber,
    size: size,
  );
}

// confirmButton(String msg, VoidCallback callback) {
//   return GestureDetector(
//     onTap: callback,
//     child: Container(
//       padding: EdgeInsets.all(10.0),
//       decoration: BoxDecoration(
//         color: THEME_COLOR,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Center(
//         child: AppMediumFont(msg: msg, color: WHITE_COLOR, fontSize: 18),
//       ),
//     ),
//   );
// }
//
// cancelButton(String msg, VoidCallback callback) {
//   return GestureDetector(
//     onTap: callback,
//     child: Container(
//       padding: EdgeInsets.all(10.0),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: RED_COLOR, width: 1.5)),
//       child: Center(
//         child: AppMediumFont(msg: msg, color: RED_COLOR, fontSize: 18),
//       ),
//     ),
//   );
// }
