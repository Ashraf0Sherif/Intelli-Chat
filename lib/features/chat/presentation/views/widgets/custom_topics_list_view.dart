import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intellichat/core/utils/widgets/show_snack_bar.dart';
import 'package:intellichat/features/auth/presentation/logic/login_cubit/login_cubit.dart';

import '../../../../../constants.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../repos/chat_repo_implementation.dart';
import '../../data/models/topic_model/topic.dart';
import '../../logic/chat_cubit/chat_cubit.dart';

class CustomTopicsListView extends StatelessWidget {
  const CustomTopicsListView({super.key, required this.topics});

  final List<Topic> topics;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: topics.length,
      itemBuilder: (context, index) {
        return InkWell(
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) {
                return BlocProvider(
                  create: (context) =>
                      ChatCubit(getIt.get<ChatRepoImplementation>()),
                  child: CustomRemoveAlertDialog(topic: topics[index]),
                );
              },
            );
          },
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              border:
                  Border.all(color: Colors.white.withOpacity(0.3), width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                topics[index].title!,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        );
      },
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 10,
        );
      },
    );
  }
}

class CustomRemoveAlertDialog extends StatefulWidget {
  const CustomRemoveAlertDialog({super.key, required this.topic});

  final Topic topic;

  @override
  State<CustomRemoveAlertDialog> createState() =>
      _CustomRemoveAlertDialogState();
}

class _CustomRemoveAlertDialogState extends State<CustomRemoveAlertDialog> {
  void _removeChat() {
    BlocProvider.of<ChatCubit>(context).removeChat(
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
                  _removeChat();
                }
              },
              child: const Text("YES")),
          TextButton(
            onPressed: () {},
            child: Text("Rename"),
          )
        ],
      ),
    );
  }
}
