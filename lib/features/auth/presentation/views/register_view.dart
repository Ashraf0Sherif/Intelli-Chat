import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intellichat/core/utils/widgets/show_loading_dialog.dart';
import 'package:intellichat/core/utils/widgets/show_snack_bar.dart';
import 'package:intellichat/features/auth/presentation/logic/register_cubit/register_cubit.dart';
import 'package:intellichat/features/auth/presentation/views/widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          showSnackBar(context, message: state.errorMessage);
          Navigator.of(context).pop();
        } else if (state is RegisterLoading) {
          showLoadingDialog(context);
        } else if (state is RegisterSuccess) {
          showSnackBar(context,
              message: "Verification email has been sent to your email");
          FirebaseAuth.instance.currentUser!.sendEmailVerification();
          Navigator.of(context).pop();
          Navigator.pop(context);
        }
      },
      child: const RegisterViewBody(),
    );
  }
}
