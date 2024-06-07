import 'package:flutter/material.dart';
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
            child: RiveAnimation.asset('assets/rive/new_file.riv'),
          ),
          Text(
            "Hello Boss!",
            style: TextStyle(fontSize: 36),
          ),
          Text(
            "I'm ready for help you",
            style: TextStyle(fontSize: 26),
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
