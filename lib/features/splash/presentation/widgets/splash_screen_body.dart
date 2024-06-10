import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as get_transitions;
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/assets_data.dart';
import '../../../auth/presentation/logic/login_cubit/login_cubit.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  void _homeNavigation() {
    if (FirebaseAuth.instance.currentUser == null) {
      Future.delayed(
        const Duration(seconds: 1),
        () => AppRouter.pushReplacementNavigation(
          view: AppRouter.kOnboarding,
          milliseconds: 1200,
          transition: get_transitions.Transition.fadeIn,
        ),
      );
    } else {
      BlocProvider.of<LoginCubit>(context)
          .fetchUser(firebaseUser: FirebaseAuth.instance.currentUser!);
      Future.delayed(
        const Duration(seconds: 1),
        () => AppRouter.pushReplacementNavigation(
          view: AppRouter.kChatView,
          milliseconds: 1200,
          transition: get_transitions.Transition.fadeIn,
        ),
      );
    }
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
