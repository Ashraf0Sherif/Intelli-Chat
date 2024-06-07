import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:intellichat/core/router/app_router.dart';

import '../../../../../core/utils/widgets/login_method.dart';

class AuthContainer extends StatelessWidget {
  const AuthContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const LoginMethod(
              icon: FontAwesomeIcons.google,
              text: "Continue With Google",
            ),
            const SizedBox(
              height: 10,
            ),
            const LoginMethod(
              icon: FontAwesomeIcons.solidEnvelope,
              text: "Sign Up With Email",
            ),
            const SizedBox(
              height: 10,
            ),
            LoginMethod(
              onTap: () {
                AppRouter.pushNavigation(
                    view: AppRouter.kLoginView,
                    milliseconds: 240,
                    transition: Transition.leftToRightWithFade);
              },
              text: "Login to existing account",
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
