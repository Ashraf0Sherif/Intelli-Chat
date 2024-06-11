import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intellichat/features/auth/presentation/logic/login_cubit/login_cubit.dart';

import '../../../../../constants.dart';
import 'dash_chat_body.dart';

class CustomDashChat extends StatelessWidget {
  const CustomDashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is LoginFetchUserLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        } else if (state is LoginFetchUserSuccess) {
          return const DashChatBody();
        } else {
          return Container();
        }
      },
    );
  }
}
