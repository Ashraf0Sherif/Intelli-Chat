import 'package:flutter/material.dart';
import 'package:flutter/painting.dart' as painting;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart'
as get_transitions;
import 'package:rive/rive.dart';

import '../../../../../constants.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/utils/assets_data.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/utils/widgets/login_method.dart';
import '../../../../../core/utils/widgets/my_behavior.dart';
import '../../logic/login_cubit/login_cubit.dart';
import 'custom_password_text_form_field.dart';
import 'custom_text_form_field.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
              padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
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
                        AssetsData.kRiveRobot,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Welcome back to login!",
                      style: Styles.kTextStyle28,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Login to your account. Get easier than search engines results.",
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
                    Center(
                      child: LoginMethod(
                        text: 'Login',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<LoginCubit>(context)
                                .loginUsingEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text);
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
                    Center(
                      child: LoginMethod(
                        onTap: () {
                          BlocProvider.of<LoginCubit>(context)
                              .loginUsingGoogle();
                        },
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
                              AppRouter.pushNavigation(
                                  view: AppRouter.kRegisterView,
                                  milliseconds: 240,
                                  transition: get_transitions
                                      .Transition.leftToRightWithFade);
                            },
                            child: const Text(
                              "Create an account",
                              style: TextStyle(color: kSecondaryColor2),
                              overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}
