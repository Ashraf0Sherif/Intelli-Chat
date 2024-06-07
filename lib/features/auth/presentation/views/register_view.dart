import 'package:flutter/material.dart';
import 'package:flutter/painting.dart' as painting;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intellichat/core/utils/styles.dart';
import 'package:intellichat/features/auth/presentation/views/widgets/custom_password_text_form_field.dart';
import 'package:intellichat/features/auth/presentation/views/widgets/custom_text_form_field.dart';

import '../../../../constants.dart';
import '../../../../core/utils/widgets/login_method.dart';
import '../../../../core/utils/widgets/my_behavior.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView(
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: SvgPicture.asset(
                      'assets/images/Fingerprint-cuate 1.svg',
                    ),
                  ),
                  const Text(
                    "Create an account.",
                    style: Styles.kTextStyle28,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Sign for a free account. Get easier than search engines results.",
                    style: Styles.kTextStyle16.copyWith(color: Colors.grey),
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
                  CustomPasswordTextFormField(
                    label: 'Password',
                    passwordController: _passwordController,
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  CustomPasswordTextFormField(
                    label: 'Confirm Password',
                    passwordController: _confirmPasswordController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: LoginMethod(text: 'Create account'),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Already have an account? "),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: kSecondaryColor2),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
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
