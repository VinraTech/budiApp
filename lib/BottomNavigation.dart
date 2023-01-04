import 'package:budi/BottomNavigationScreens/AgentPage.dart';
import 'package:budi/BottomNavigationScreens/HomePage.dart';
import 'package:budi/BottomNavigationScreens/PercentPage.dart';
import 'package:budi/BottomNavigationScreens/ProfilePage.dart';
import 'package:budi/BottomNavigationScreens/SearchPage.dart';
import 'package:budi/Models/UserInfoModel.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:flutter/material.dart';


class BottomNavigation extends StatefulWidget {
  int? index = 0;
  UserInfoModel? userInfoModel;

  BottomNavigation({Key? key, this.index,this.userInfoModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BottomNavigationState();
  }
}

class _BottomNavigationState extends State<BottomNavigation> {
  int? _currentPageIndex = 0;
  List<Widget> _pages = [];
  String? profileType;

  Widget _getCurrentPage() => _pages[_currentPageIndex!];
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    _currentPageIndex = 0;
    setState(() {
      _pages.add(HomePage(userInfoModel: widget.userInfoModel,));
      _pages.add(SearchPage(isHome: false));
      _pages.add(AgentPage());
      _pages.add(PercentPage());
      _pages.add(ProfilePage());
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _getCurrentPage(),
        // floatingActionButton: keyboardIsOpened
        //     ? null
        //     : Padding(
        //   padding: EdgeInsets.only(top: 20),
        //   child: SizedBox(
        //     height: 60,
        //     width: 60,
        //   ),
        // ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _currentPageIndex!,
          onTap: (index) {
            setState(() {
              _currentPageIndex = index;
            });
            if (_currentPageIndex == 1) {
              isSelected = true;
            } else {
              isSelected = false;
            }
          },
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Image.asset(Assets.ic_Home,
                  width: 22, height: 22),
              label: 'Home',
              activeIcon: Image.asset(Assets.ic_Home_Select,
                  width: 22, height: 22),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Image.asset(Assets.ic_Search,
                  width: 22, height: 22),
              label: "Search",
              activeIcon: Image.asset(Assets.ic_Search_Select,
                  width: 22, height: 22),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Image.asset(Assets.ic_Luggage,
                  width: 22, height: 22),
              label: "Agents",
              activeIcon: Image.asset(Assets.ic_Luggage_Select,
                  width: 22, height: 22),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Image.asset(Assets.ic_Percent,
                  width: 22, height: 22),
              label: "Offers",
              activeIcon: Image.asset(Assets.ic_Percent_Select,
                  width: 22, height: 22),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Image.asset(Assets.ic_Account_Circle,
                  width: 20, height: 20),
              label: "Account",
              activeIcon: Image.asset(Assets.ic_Account_Circle_Select,
                  width: 22, height: 22),
            ),
          ],
          // selectedLabelStyle: _currentPageIndex == 0 ||
          //     _currentPageIndex == 1 ||
          //     _currentPageIndex == 2 ||
          //     _currentPageIndex == 3 ||
          //     _currentPageIndex == 4
          //     ? TextStyle(
          //     fontSize: 16,color: Colors.grey)
          //     : TextStyle(
          //     fontSize: 16,color: Colors.grey),
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.grey,
          selectedFontSize: 14,
          unselectedFontSize: 14,
        ),
      ),
    );
  }
}