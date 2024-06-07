import 'package:flutter/material.dart';
import 'package:flutter/painting.dart' as painting;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intellichat/core/utils/styles.dart';

import '../../../../constants.dart';
import '../../../../core/utils/widgets/login_method.dart';
import '../../../../core/utils/widgets/my_behavior.dart';
import '../widgets/custom_password_text_form_field.dart';
import '../widgets/custom_text_form_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
                  const CustomPasswordTextFormField(label: 'Password'),
                  const SizedBox(
                    height: 26,
                  ),
                  const CustomPasswordTextFormField(label: 'Confirm Password'),
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
