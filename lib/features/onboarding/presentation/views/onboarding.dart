import 'package:flutter/material.dart';
import 'package:intellichat/core/utils/widgets/my_behavior.dart';
import 'package:intellichat/features/onboarding/presentation/views/widgets/auth_container.dart';
import 'package:intellichat/features/onboarding/presentation/views/widgets/on_boarding_body.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(
          children: const [
            OnBoardingBody(),
            SizedBox(
              height: 20,
            ),
            AuthContainer()
          ],
        ),
      ),
    );
  }
}
