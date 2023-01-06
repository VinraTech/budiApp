import 'package:budi/Common%20Fields/AppDailogBox.dart';
import 'package:budi/Models/NearByAgentsModel.dart';
import 'package:budi/Models/UserInfoModel.dart';
import 'package:budi/Utilities/AppColor.dart';
import 'package:budi/Utilities/TextHelper.dart';
import 'package:flutter/material.dart';

class TabReview extends StatefulWidget {
  User? user;

  TabReview({Key? key, this.user}) : super(key: key);

  @override
  State<TabReview> createState() => _TabReviewState();
}

class _TabReviewState extends State<TabReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.user!.agentReviews!.isNotEmpty ||
          widget.user!.agentReviews == null
          ? SizedBox(
        height: 600,
        child: ListView.builder(
            itemCount: widget.user?.agentReviews?.length,
            itemBuilder: (context, index) {
              return Card(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/ic_DemoTwoImage.png',
                            height: 180,
                            width: 120,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    widget.user?.agentReviews?[index].rating ==
                                            1
                                        ? starIcon(Icons.star, 12)
                                        : const SizedBox(),
                                    widget.user?.agentReviews?[index].rating ==
                                            2
                                        ? starIcon(Icons.star, 12)
                                        : const SizedBox(),
                                    widget.user?.agentReviews?[index].rating ==
                                            3
                                        ? starIcon(Icons.star, 12)
                                        : const SizedBox(),
                                    widget.user?.agentReviews?[index].rating ==
                                            4
                                        ? starIcon(Icons.star, 12)
                                        : const SizedBox(),
                                    widget.user?.agentReviews?[index].rating ==
                                            5
                                        ? starIcon(Icons.star, 12)
                                        : const SizedBox(),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                getSemiBoldText(
                                    msg: widget
                                            .user?.agentReviews?[index].title ??
                                        '',
                                    fontSize: 16,
                                    color: AppColor.BUTTON_COLOR),
                                const SizedBox(
                                  height: 10,
                                ),
                                getRegularStyleText(
                                    msg: widget
                                            .user?.agentReviews?[index].body ??
                                        '',
                                    textAlign: TextAlign.center,
                                    fontSize: 14),
                                const SizedBox(
                                  height: 10,
                                ),
                                getRegularStyleText(
                                    msg: 'Jake Stevens',
                                    fontSize: 12,
                                    color: AppColor.TEXT_COLOR)
                              ],
                            ),
                          )
                        ],
                      ),
                    );
            }),
      ):Center(
        child: getRegularStyleText(
            msg: 'No Reviews Yet', color: AppColor.DARKBLUE),
      ),
    );
  }
}
