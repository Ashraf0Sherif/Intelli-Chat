import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/utils/assets_data.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  void _homeNavigation() {
    Future.delayed(
      const Duration(seconds: 1),
      () => AppRouter.pushReplacementNavigation(
        view: FirebaseAuth.instance.currentUser == null
            ? AppRouter.kOnboarding
            : AppRouter.kChatView,
        milliseconds: 1200,
        transition: Transition.fadeIn,
      ),
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
