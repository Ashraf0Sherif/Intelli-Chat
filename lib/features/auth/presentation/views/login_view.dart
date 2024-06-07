import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as get_transitions;
import 'package:intellichat/core/router/app_router.dart';
import 'package:intellichat/core/utils/widgets/show_loading_dialog.dart';
import 'package:intellichat/features/auth/presentation/logic/login_cubit/login_cubit.dart';
import 'package:intellichat/features/auth/presentation/views/widgets/login_view_body.dart';

import '../../../../core/utils/widgets/show_snack_bar.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          showSnackBar(context, message: state.errorMessage);
          Navigator.of(context).pop();
        } else if (state is LoginLoading) {
          showLoadingDialog(context);
        } else if (state is LoginSuccess) {
          if (state.credential.user!.emailVerified) {
            AppRouter.pushReplacementAll(
                view: AppRouter.kHomeView,
                milliseconds: 1200,
                transition: get_transitions.Transition.fadeIn);
          } else {
            showSnackBar(context, message: "Your email is not verified");
            Navigator.of(context).pop();
          }
        } else if (state is LoginResetPasswordSuccess) {
          showSnackBar(context,
              message:
                  "Password reset instructions sent to your email. Check your inbox");
          Navigator.of(context).pop();
        } else if (state is LoginResetPasswordLoading) {
          showLoadingDialog(context);
        } else if (state is LoginResetPasswordFailure) {
          showSnackBar(context, message: state.errorMessage);
        }
      },
      child: const LoginViewBody(),
    );
  }
}
