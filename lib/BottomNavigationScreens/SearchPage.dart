import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/Common%20Fields/AppTextField.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool isStreamed = true;

class SearchPage extends StatefulWidget {
  bool? isHome;

  SearchPage({Key? key, this.isHome}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.OFF_WHITE_COLOR,
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 60,
            ),
            AppTextField(
              prefixIcon: Assets.ic_Search,
              hintText: 'Search',
              obscureText: false,
              enable: true,
              isSearch: true,
              controller: searchController,
              onFilterTap: (){
                showDialogue();
              },
            ),
            Container(
                height: widget.isHome == false
                    ? MediaQuery.of(context).size.height * 0.76
                    : MediaQuery.of(context).size.height - 150,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 15, right: 15),
                child: GridView.builder(
                  itemCount: 20,
                  padding: const EdgeInsets.all(0.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 153 / 180,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: 163,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: Card(
                        elevation: 3,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Stack(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.greenAccent[400],
                                  radius: 30,
                                  child: Image.asset(
                                      'assets/images/Image.png'), //Text
                                ),
                                Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Image.asset(
                                      Assets.icVerified,
                                      height: 16,
                                      width: 16,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            textView('Alex Buckmaster', 16, AppColor.HOMETEXT),
                            SizedBox(
                              height: 6,
                            ),
                            textView('14 projects', 12, AppColor.TEXT_COLOR),
                            SizedBox(
                              height: 6,
                            ),
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
                            SizedBox(
                              height: 6,
                            ),
                            textView(
                                'At vero eos et \n accusamus et iusto \n odio',
                                12,
                                AppColor.HOMETEXT)
                          ],
                        ),
                      ),
                    );
                    ;
                  },
                ))
          ]),
        ));
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

  showDialogue(){
    return showDialog<String>(
        context: context,
        builder: (ctxDialog) => 
            SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(top: 100.0),
                    child: AlertDialog(
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                              width: 80,
                              child: getRegularStyleText(
                                  msg: 'Radius',
                                  color: AppColor.SIGNIN_COLOR,
                                  fontSize: 14,
                                  textAlign: TextAlign.left)),
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              width: 80,
                              child: getSemiBoldText(
                                  msg: '5 Km',
                                  color: AppColor.SIGNIN_COLOR,
                                  fontSize: 14,
                                  textAlign: TextAlign.left)),
                          Container(
                            margin: EdgeInsets.only(left: 10,),
                            height: 1,
                            width: 130,
                            color:AppColor.SIGNIN_COLOR,
                          ),
                          SizedBox(height: 10,),
                          budiBasics(context,setState),
                          budiBasics(context,setState),
                          budiBasics(context,setState),

                  Container(
                    height: 60,
                    child: AppButton(
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      color: AppColor.BUTTON_COLOR,
                      label: 'Filter',
                      onTap: () {

                      },
                    ),
                  ),
                        ],),
                    )
                )
            )
    );
  }

  Widget budiBasics(
      BuildContext? context, void Function(VoidCallback fn) setState) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      width: 320,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 8,),
              height: 8,
              child: Transform.scale(
                  scale: 0.6,
                  child: CupertinoSwitch(
                    activeColor: AppColor.BUTTON_COLOR,
                    value: isStreamed != null ? isStreamed : false,
                    onChanged: (bool value) {
                      setState(() {
                        isStreamed = value;
                      });
                    },
                  ))),
          Container(
            margin: EdgeInsets.only(bottom: 8),
              width: 80,
              child: getSemiBoldText(
                  msg: 'Budi Basic',
                  color: AppColor.SIGNIN_COLOR,
                  fontSize: 14,
                  textAlign: TextAlign.left)),
          SizedBox(width: 45,),
          Container(
            margin: EdgeInsets.only(bottom: 8),
              width: 80,
              child: getRegularStyleText(
                  msg: '332 offers',
                  color: AppColor.SIGNIN_COLOR,
                  fontSize: 14,
                  textAlign: TextAlign.left)),
        ],
      ),
    );
  }
}
