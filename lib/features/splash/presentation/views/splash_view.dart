import 'package:flutter/material.dart';
import 'package:intellichat/features/splash/presentation/widgets/splash_screen_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashViewBody(),
    );
  }
}
