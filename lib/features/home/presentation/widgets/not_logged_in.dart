import 'package:flutter/material.dart';
import 'package:intellichat/core/utils/assets_data.dart';
import 'package:intellichat/core/utils/styles.dart';
import 'package:intellichat/core/utils/widgets/my_behavior.dart';
import 'package:rive/rive.dart';

class NotLoggedIn extends StatelessWidget {
  const NotLoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView(
        children: const [
          SizedBox(
            height: 180,
            child: RiveAnimation.asset(AssetsData.kRiveChatting),
          ),
          Center(
            child: Text(
              "Hello Boss!",
              style: Styles.kTextStyle36,
            ),
          ),
          Center(
            child: Text(
              "I'm ready for help you",
              style: Styles.kTextStyle26,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Ask my anything what's on your mind. I'm here to assist you!",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
