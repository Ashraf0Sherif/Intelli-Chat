import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intellichat/core/utils/styles.dart';
import 'package:flutter/painting.dart' as painting;
import 'package:intellichat/features/auth/presentation/logic/register_cubit/register_cubit.dart';
import 'package:intellichat/features/auth/presentation/views/widgets/custom_password_text_form_field.dart';
import 'package:intellichat/features/auth/presentation/views/widgets/custom_text_form_field.dart';

import '../../../../../constants.dart';
import '../../../../../core/utils/widgets/login_method.dart';
import '../../../../../core/utils/widgets/my_behavior.dart';
import '../../../../../core/utils/widgets/show_snack_bar.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

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
        body: Form(
          key: _formKey,
          autovalidateMode: autoValidateMode,
          child: Container(
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
                        label: 'Username',
                        hintText: "Enter Your username",
                        onChanged: (text) {},
                        controller: _usernameController),
                    const SizedBox(
                      height: 26,
                    ),
                    CustomTextFormField(
                        label: 'Email',
                        hintText: "Enter Your Email",
                        onChanged: (text) {},
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
                    Center(
                      child: LoginMethod(
                        text: 'Create account',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            if (_passwordController.text !=
                                _confirmPasswordController.text) {
                              showSnackBar(context,
                                  message:
                                      "The passwords entered do not match.");
                            } else {
                              BlocProvider.of<RegisterCubit>(context)
                                  .signupUsingEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                                username: _usernameController.text,
                              );
                            }
                          } else {
                            autoValidateMode = AutovalidateMode.always;
                            setState(() {});
                          }
                        },
                      ),
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
      ),
    );
  }
}
