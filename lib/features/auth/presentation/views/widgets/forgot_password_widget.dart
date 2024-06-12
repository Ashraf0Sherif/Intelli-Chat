import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants.dart';
import '../../logic/login_cubit/login_cubit.dart';

class ForgotPasswordWidget extends StatefulWidget {
  const ForgotPasswordWidget({super.key});

  @override
  State<ForgotPasswordWidget> createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  final GlobalKey<FormState> _dialogFormKey = GlobalKey();
  AutovalidateMode dialogAutovalidateMode = AutovalidateMode.disabled;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: _dialogFormKey,
        autovalidateMode: dialogAutovalidateMode,
        child: AlertDialog(
          backgroundColor: kPrimaryColor,
          content: TextFormField(
            controller: _controller,
            cursorColor: kSecondaryColor2,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return "Field is required";
              }
              return null;
            },
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kSecondaryColor,
                ),
              ),
              hintText: "Enter your email",
            ),
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kPrimaryColor)),
              onPressed: () {
                if (_dialogFormKey.currentState!.validate()) {
                  BlocProvider.of<LoginCubit>(context)
                      .resetPassword(email: _controller.text);
                  Navigator.of(context).pop();
                } else {
                  dialogAutovalidateMode = AutovalidateMode.always;
                  setState(() {});
                }
              },
              child: const Text("Reset password"),
            )
          ],
        ),
      ),
    );
  }
}
