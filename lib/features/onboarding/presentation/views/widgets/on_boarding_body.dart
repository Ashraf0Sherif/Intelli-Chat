import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:intellichat/core/utils/styles.dart';
import 'package:intellichat/core/utils/widgets/custom_button.dart';

import '../../../../../core/router/app_router.dart';
import '../../../../../core/utils/assets_data.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Image.asset(
                AssetsData.kLogoPic,
                height: 50,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text("Intelli-Chat")
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Start Free Conversation",
            style: Styles.kTextStyle38,
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "No login required for get started chat with our AI powered chagbot.",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text("Feel free to ask what you want to know.",
              style: TextStyle(color: Colors.grey)),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: CustomButton(
              label: 'Skip',
              onPressed: () {
                AppRouter.pushNavigation(
                    view: AppRouter.kHomeView,
                    milliseconds: 240,
                    transition: Transition.leftToRightWithFade);
              },
            ),
          ),
        ],
      ),
    );
  }
}
