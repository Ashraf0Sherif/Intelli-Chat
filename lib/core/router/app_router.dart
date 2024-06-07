import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:intellichat/features/onboarding/presentation/views/onboarding.dart';

import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/register_view.dart';
import '../../features/home/presentation/views/home_view.dart';

abstract class AppRouter {
  static const kHomeView = "/homeView";
  static const kLoginView = "/LoginView";
  static const kRegisterView = "/registerView";
  static const kOnboarding = "/onboarding";
  static final Map<String, Widget> _views = {
    kHomeView: const HomeView(),
    kLoginView: const LoginView(),
    kRegisterView: const RegisterView(),
    kOnboarding: const OnBoarding(),
  };

  static void pushNavigation(
      {required String view, Transition? transition, int? milliseconds}) {
    Get.to(
      _views[view],
      transition: transition ?? Transition.fade,
      duration: Duration(milliseconds: milliseconds ?? 1500),
    );
  }

  static void pushReplacementNavigation(
      {required String view, Transition? transition, int? milliseconds}) {
    Get.off(
      _views[view],
      transition: transition ?? Transition.fade,
      duration: Duration(milliseconds: milliseconds ?? 1500),
    );
  }
}
