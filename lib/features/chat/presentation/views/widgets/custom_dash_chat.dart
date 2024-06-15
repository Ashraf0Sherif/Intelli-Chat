import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intellichat/core/utils/widgets/show_snack_bar.dart';
import 'package:intellichat/features/auth/presentation/logic/login_cubit/login_cubit.dart';

import '../../../../../constants.dart';
import 'dash_chat_body.dart';

class CustomDashChat extends StatelessWidget {
  const CustomDashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is LoginFetchUserSuccess || state is LoginChangeTopicID) {
          return DashChatBody(
            currentTopicID:
                BlocProvider.of<LoginCubit>(context).currentTopicId!,
          );
        } else {
          return const SpinKitCubeGrid(
            color: kSecondaryColor2,
          );
        }
      },
      listener: (BuildContext context, LoginState state) {
        if (state is LoginFetchUserFailure) {
          showSnackBar(context, message: state.errorMessage);
        }
      },
    );
  }
}
