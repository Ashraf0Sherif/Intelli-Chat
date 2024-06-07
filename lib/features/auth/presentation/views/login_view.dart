import 'package:flutter/material.dart';
import 'package:flutter/painting.dart' as painting;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intellichat/core/utils/widgets/login_method.dart';
import 'package:intellichat/core/utils/widgets/my_behavior.dart';
import 'package:intellichat/features/auth/presentation/views/register_view.dart';
import 'package:intellichat/features/auth/presentation/widgets/custom_password_text_form_field.dart';
import 'package:intellichat/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:rive/rive.dart';

import '../../../../constants.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: painting.LinearGradient(
              colors: [kPrimaryColor, kSecondaryColor],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 75,
                    child: RiveAnimation.asset(
                      'assets/rive/sendwave.riv',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Welcome back to login!",
                    style: TextStyle(fontSize: 28),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Login to your account. Get easier than search engines results.",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  CustomTextFormField(
                      label: 'Email',
                      hintText: "Enter Your Email",
                      onChanged: (te) {},
                      controller: _emailController),
                  const SizedBox(
                    height: 26,
                  ),
                  const CustomPasswordTextFormField(label: 'Password'),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: const Text("Reset Password")),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: LoginMethod(text: 'Login'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: LoginMethod(
                      icon: FontAwesomeIcons.google,
                      text: "Continue With Google",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const RegisterView();
                                },
                              ),
                            );
                          },
                          child: const Text(
                            "Create an account",
                            style: TextStyle(color: kSecondaryColor2),
                            overflow: TextOverflow.ellipsis ,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
