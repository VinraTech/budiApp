import 'dart:convert';
import 'package:budi/AgentSection/AgentsProfile.dart';
import 'package:budi/Common%20Fields/CircularIndicator.dart';
import 'package:budi/Helpers/AppIndicator.dart';
import 'package:http/http.dart' as http;
import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/Common%20Fields/AppTextField.dart';
import 'package:budi/Models/FeaturedAgentsModel.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isStreamed = true;

class SearchPage extends StatefulWidget {
  bool? isHome;

  SearchPage({Key? key, this.isHome}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  FeaturedAgentsModel? featuredAgents;

  getFeaturedAgents() async {
    try {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('LogInToken');
      var userId = sharedPreferences.getString('UserId');
      final res = await http
          .get(Uri.parse("http://74.208.150.111/api/users/featured_agents"), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      final int statusCode = res.statusCode;
      if (statusCode == 200) {
        Map<String, dynamic> decoded = json.decode(res.body);
        FeaturedAgentsModel data = FeaturedAgentsModel.fromJson(decoded);
        featuredAgents = data;
        setState(() {});
      } else {
        print(statusCode);
      }
    } catch (exception) {
      print("Please Check Internet");
    }
  }

  searchAgents(String query) async {
    AppIndicator.loadingIndicator();
    try {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('LogInToken');
      var userId = sharedPreferences.getString('UserId');
      final res = await http
          .get(Uri.parse("http://74.208.150.111/api/users/search_agent?name=$query"), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      final int statusCode = res.statusCode;
      if (statusCode == 200) {
        featuredAgents = null;
        Map<String, dynamic> decoded = json.decode(res.body);
        FeaturedAgentsModel data = FeaturedAgentsModel.fromJson(decoded);
        AppIndicator.disposeIndicator();
        featuredAgents = data;
        setState(() {});
      } else {
        print(statusCode);
      }
    } catch (exception) {
      print("Please Check Internet");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getFeaturedAgents();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.OFF_WHITE_COLOR,
        body: featuredAgents != null ? SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 60,
            ),
            AppTextField(
              prefixIcon: Assets.ic_Search,
              hintText: 'Search',
              obscureText: false,
              enable: true,
              isSearch: true,
              controller: searchController,
              onChanged: (m){},
              onSubmitted: (m){
                m.isNotEmpty ? searchAgents(m): null;
              },
              onFilterTap: (){
                // showDialogue();
              },
            ),
            Container(
                height: widget.isHome == false
                    ? MediaQuery.of(context).size.height * 0.76
                    : MediaQuery.of(context).size.height - 150,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: GridView.builder(
                  itemCount: featuredAgents?.agents?.length,
                  padding: const EdgeInsets.all(0.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 153 / 185,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AgentsProfilePage(
                                        user: featuredAgents?.agents?[index])));
                      },
                      child: Container(
                        width: 163,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: Card(
                          elevation: 3,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.greenAccent[400],
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                        featuredAgents?.agents?[index].profile?.profilePicture ?? ''),//Text
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
                              const SizedBox(
                                height: 6,
                              ),
                              textView( featuredAgents?.agents?[index].name ?? '', 16, AppColor.HOMETEXT),
                              const SizedBox(
                                height: 6,
                              ),
                              textView('14 projects', 12, AppColor.TEXT_COLOR),
                              const SizedBox(
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
                              const SizedBox(
                                height: 6,
                              ),
                              textView(
                                  'At vero eos et \n accusamus et iusto \n odio',
                                  12,
                                  AppColor.HOMETEXT)
                            ],
                          ),
                        ),
                      ),
                    );
                    ;
                  },
                ))
          ]),
        ): circularIndicator(context));
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
                    padding: const EdgeInsets.only(top: 100.0),
                    child: AlertDialog(
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                              width: 80,
                              child: getRegularStyleText(
                                  msg: 'Radius',
                                  color: AppColor.SIGNIN_COLOR,
                                  fontSize: 14,
                                  textAlign: TextAlign.left)),
                          Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 80,
                              child: getSemiBoldText(
                                  msg: '5 Km',
                                  color: AppColor.SIGNIN_COLOR,
                                  fontSize: 14,
                                  textAlign: TextAlign.left)),
                          Container(
                            margin: const EdgeInsets.only(left: 10,),
                            height: 1,
                            width: 130,
                            color:AppColor.SIGNIN_COLOR,
                          ),
                          const SizedBox(height: 10,),
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
      margin: const EdgeInsets.only(top: 8),
      width: 320,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.only(bottom: 8,),
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
            margin: const EdgeInsets.only(bottom: 8),
              width: 80,
              child: getSemiBoldText(
                  msg: 'Budi Basic',
                  color: AppColor.SIGNIN_COLOR,
                  fontSize: 14,
                  textAlign: TextAlign.left)),
          const SizedBox(width: 45,),
          Container(
            margin: const EdgeInsets.only(bottom: 8),
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
