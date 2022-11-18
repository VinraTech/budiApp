import 'package:budi/Common%20Fields/AppButton.dart';
import 'package:budi/Login%20Section/LoginPage.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/Assets.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  String? role;
  IntroScreen({Key? key,this.role}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController? _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.5,
            child: PageView(
              onPageChanged: (int page) {
                setState(() {
                  currentIndex = page;
                });
              },
              controller: _pageController,
              children: <Widget>[
                makePage(
                    image: Assets.icIntroImage1,
                    title: "Travel",
                    content:
                        "Come travel the world with us and see how easy vacationing can be"),
                makePage(
                    // reverse: true,
                    image: Assets.icIntroImage2,
                    title: "Experience",
                    content:
                        "Relax and recharge like you've never done before with tons of services at your fingertips"),
                makePage(
                    image: Assets.icIntroImage3,
                    title: "Share",
                    content:
                        "Share your favourite photos and experiences with friends family and the world at large"),
              ],
            ),
          ),
          currentIndex == 2
              ? AppButton(
                  width: MediaQuery.of(context).size.width / 2.6,
                  height: 55,
                  color: AppColor.BUTTON_COLOR,
                  label: 'Get Started',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage(role: widget.role,)));
                  },
                )
              : buttonView(),
        ],
      ),
    );
  }

  Widget makePage({image, title, content, reverse = false}) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          !reverse
              ? Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width * 0.70,
                      child: Image.asset(image),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                )
              : SizedBox(),
          Text(
            title,
            style: TextStyle(
                color: Color.fromRGBO(52, 43, 37, 1),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            content,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w400),
          ),
          reverse
              ? Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(image),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30 : 6,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: Color.fromRGBO(198, 116, 27, 1),
          borderRadius: BorderRadius.circular(5)),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }

  Widget buttonView() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppButton(
            width: MediaQuery.of(context).size.width / 2.6,
            height: 55,
            color: AppColor.BUTTON_COLOR,
            label: 'Continue',
            onTap: () {
              _pageController?.jumpToPage(currentIndex + 1);
            },
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage(role: widget.role,)));
            },
            child: Text(
              'Skip',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
