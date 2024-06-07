import 'package:flutter/material.dart';
import 'package:intellichat/core/utils/widgets/custom_button.dart';
import 'package:intellichat/features/home/presentation/views/home_view.dart';

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
            style: TextStyle(fontSize: 38),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const HomeView();
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
