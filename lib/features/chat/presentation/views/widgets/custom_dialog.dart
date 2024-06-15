import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intellichat/core/utils/widgets/show_snack_bar.dart';

import '../../../../../constants.dart';
import '../../../../auth/presentation/logic/login_cubit/login_cubit.dart';
import '../../logic/chat_cubit/chat_cubit.dart';

class CustomCreateAlertDialog extends StatefulWidget {
  const CustomCreateAlertDialog({
    super.key,
  });

  @override
  State<CustomCreateAlertDialog> createState() =>
      _CustomCreateAlertDialogState();
}

class _CustomCreateAlertDialogState extends State<CustomCreateAlertDialog> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _dialogFormKey = GlobalKey();
  AutovalidateMode dialogAutovalidateMode = AutovalidateMode.disabled;

  void _addTopic() {
    BlocProvider.of<ChatCubit>(context).createTopic(
        firebaseUser: FirebaseAuth.instance.currentUser!,
        title: _controller.text);
    BlocProvider.of<LoginCubit>(context)
        .fetchUser(firebaseUser: FirebaseAuth.instance.currentUser!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatNewChatSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: Form(
        key: _dialogFormKey,
        autovalidateMode: dialogAutovalidateMode,
        child: AlertDialog(
          backgroundColor: kPrimaryColor,
          title: const Text('Create new topic'),
          actions: [
            TextButton(
              onPressed: () {
                if (_dialogFormKey.currentState!.validate()) {
                  if (BlocProvider.of<LoginCubit>(context).networkConnection) {
                    _addTopic();
                  } else {
                    Navigator.of(context).pop();
                    showSnackBar(context, message: kNoInternetMessage);
                  }
                } else {
                  dialogAutovalidateMode = AutovalidateMode.always;
                  setState(() {});
                }
              },
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
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
              hintText: "Topic title",
            ),
          ),
        ),
      ),
    );
  }
}
