import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intellichat/core/utils/widgets/show_snack_bar.dart';

import '../../../../../constants.dart';
import '../../../../auth/presentation/logic/login_cubit/login_cubit.dart';
import '../../logic/chat_cubit/chat_cubit.dart';

class RenameTopicWidget extends StatefulWidget {
  const RenameTopicWidget({super.key, required this.topicID});

  final String topicID;

  @override
  State<RenameTopicWidget> createState() => _RenameTopicWidgetState();
}

class _RenameTopicWidgetState extends State<RenameTopicWidget> {
  final GlobalKey<FormState> _dialogFormKey = GlobalKey();
  AutovalidateMode dialogAutovalidateMode = AutovalidateMode.disabled;
  final TextEditingController _controller = TextEditingController();

  void _renameTopic({required String newTitle}) {
    BlocProvider.of<ChatCubit>(context).renameTopic(
        firebaseUser: FirebaseAuth.instance.currentUser!,
        topicID: widget.topicID,
        newTitle: newTitle);
    BlocProvider.of<LoginCubit>(context)
        .fetchUser(firebaseUser: FirebaseAuth.instance.currentUser!);
  }

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
              hintText: "New title",
            ),
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kPrimaryColor)),
              onPressed: () {
                if (_dialogFormKey.currentState!.validate()) {
                  if (BlocProvider.of<LoginCubit>(context).networkConnection) {
                    _renameTopic(newTitle: _controller.text);
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pop();
                    showSnackBar(context, message: kNoInternetMessage);
                  }
                } else {
                  dialogAutovalidateMode = AutovalidateMode.always;
                  setState(() {});
                }
              },
              child: const Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
