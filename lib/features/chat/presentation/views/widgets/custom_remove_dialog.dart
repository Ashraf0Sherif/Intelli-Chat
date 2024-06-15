import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants.dart';
import '../../../../../core/utils/widgets/show_snack_bar.dart';
import '../../../../auth/presentation/logic/login_cubit/login_cubit.dart';
import '../../../data/models/topic_model/topic.dart';
import '../../logic/chat_cubit/chat_cubit.dart';
import 'custom_rename_dialog.dart';

class CustomRemoveAlertDialog extends StatefulWidget {
  const CustomRemoveAlertDialog({super.key, required this.topic});

  final Topic topic;

  @override
  State<CustomRemoveAlertDialog> createState() =>
      _CustomRemoveAlertDialogState();
}

class _CustomRemoveAlertDialogState extends State<CustomRemoveAlertDialog> {
  void _removeChat() {
    BlocProvider.of<ChatCubit>(context).removeTopic(
        firebaseUser: FirebaseAuth.instance.currentUser!,
        topicID: widget.topic.id!);
    BlocProvider.of<LoginCubit>(context)
        .fetchUser(firebaseUser: FirebaseAuth.instance.currentUser!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatRemoveSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: AlertDialog(
        backgroundColor: kPrimaryColor,
        title: Text("Remove ${widget.topic.title} ?"),
        actions: [
          TextButton(
              onPressed: () {
                if (BlocProvider.of<LoginCubit>(context).user!.topics!.length ==
                    1) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  showSnackBar(context,
                      message: "You should have at least one topic");
                } else {
                  if (BlocProvider.of<LoginCubit>(context).networkConnection) {
                    _removeChat();
                  } else {
                    Navigator.of(context).pop();
                    showSnackBar(context, message: kNoInternetMessage);
                  }
                }
              },
              child: const Text("YES")),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              showDialog(
                context: (context),
                builder: (context) {
                  return RenameTopicWidget(
                    topicID: widget.topic.id!,
                  );
                },
              );
            },
            child: const Text("Rename"),
          )
        ],
      ),
    );
  }
}
