import 'package:flutter/material.dart';
import 'package:intellichat/features/onboarding/presentation/views/onboarding.dart';

import '../../../../core/utils/assets_data.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  void _homeNavigation() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const OnBoarding();
            },
          ),
        );
      },
    );
  }

  @override
  void initState() {
    _homeNavigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          AssetsData.kLogo,
          height: 270,
        ),
        const SizedBox(
          height: 4,
        ),
      ],
    );
  }
}
