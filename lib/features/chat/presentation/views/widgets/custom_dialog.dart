import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants.dart';
import '../../../../auth/presentation/logic/login_cubit/login_cubit.dart';
import '../../../../auth/presentation/views/widgets/custom_text_form_field.dart';
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

  void _addTopic() {
    BlocProvider.of<ChatCubit>(context).createTopic(
        firebaseUser: FirebaseAuth.instance.currentUser!,
        title: _controller.text);
    BlocProvider.of<LoginCubit>(context)
        .fetchUser(firebaseUser: FirebaseAuth.instance.currentUser!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatCubit,ChatState>(
      listener: (context, state) {
        if(state is ChatNewChatSuccess){
          Navigator.of(context).pop();
        }
      },
      child: AlertDialog(
        backgroundColor: kPrimaryColor,
        title: const Text('Enter topic title'),
        actions: [
          TextButton(
            onPressed: () {
              _addTopic();
            },
            child: const Text(
              "Submit",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
        content: CustomTextFormField(
            label: 'label', onChanged: (text) {}, controller: _controller),
      ),
    );
  }
}
