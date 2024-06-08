import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as get_transitions;
import 'package:intellichat/features/auth/presentation/logic/login_cubit/login_cubit.dart';
import 'package:intellichat/features/auth/presentation/logic/register_cubit/register_cubit.dart';
import 'package:intellichat/features/auth/repos/auth_repo_implementation.dart';
import 'package:intellichat/features/chat/presentation/logic/chat_cubit/chat_cubit.dart';
import 'package:intellichat/features/chat/presentation/views/chat_view.dart';
import 'package:intellichat/features/chat/repos/chat_repo_implementation.dart';
import 'package:intellichat/features/onboarding/presentation/views/onboarding.dart';

import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/register_view.dart';
import '../di/dependency_injection.dart';

abstract class AppRouter {
  static const kChatView = "/homeView";
  static const kLoginView = "/LoginView";
  static const kRegisterView = "/registerView";
  static const kOnboarding = "/onboarding";

  static final Map<String, Widget> _views = {
    kChatView: BlocProvider(
      create: (context) => ChatCubit(getIt.get<ChatRepoImplementation>()),
      child: const ChatView(),
    ),
    kLoginView: BlocProvider(
      create: (context) => LoginCubit(getIt.get<AuthRepoImplementation>()),
      child: const LoginView(),
    ),
    kRegisterView: BlocProvider(
      create: (context) => RegisterCubit(getIt.get<AuthRepoImplementation>()),
      child: const RegisterView(),
    ),
    kOnboarding: const OnBoarding(),
  };

  static void pushNavigation(
      {required String view,
      get_transitions.Transition? transition,
      int? milliseconds}) {
    Get.to(
      _views[view],
      transition: transition ?? get_transitions.Transition.fade,
      duration: Duration(milliseconds: milliseconds ?? 1500),
    );
  }

  static void pushReplacementNavigation(
      {required String view,
      get_transitions.Transition? transition,
      int? milliseconds}) {
    Get.off(
      _views[view],
      transition: transition ?? get_transitions.Transition.fade,
      duration: Duration(milliseconds: milliseconds ?? 1500),
    );
  }

  static void pushReplacementAll(
      {required String view,
      get_transitions.Transition? transition,
      int? milliseconds}) {
    Get.offAll(
      _views[view],
      transition: transition ?? get_transitions.Transition.fade,
      duration: Duration(milliseconds: milliseconds ?? 1500),
    );
  }
}
