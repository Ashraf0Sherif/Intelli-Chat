import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intellichat/features/auth/presentation/views/login_view.dart';

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginView();
                    },
                  ),
                );
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
