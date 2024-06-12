import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intellichat/core/utils/widgets/show_snack_bar.dart';
import 'package:intellichat/features/auth/presentation/logic/login_cubit/login_cubit.dart';

import 'dash_chat_body.dart';

class CustomDashChat extends StatelessWidget {
  const CustomDashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is LoginFetchUserSuccess) {
          return const DashChatBody();
        } else if (state is LoginFetchUserFailure) {
          showSnackBar(context, message: state.errorMessage);
        }
        return const SizedBox();
      },
    );
  }
}
