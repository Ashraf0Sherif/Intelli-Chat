import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants.dart';
import '../../data/models/topic_model/topic.dart';
import '../../logic/chat_cubit/chat_cubit.dart';
import 'custom_remove_dialog.dart';

class CustomTopicsListView extends StatefulWidget {
  const CustomTopicsListView({super.key, required this.topics});

  final List<Topic> topics;

  @override
  State<CustomTopicsListView> createState() => _CustomTopicsListViewState();
}

class _CustomTopicsListViewState extends State<CustomTopicsListView> {
  late int index;

  @override
  void initState() {
    index = BlocProvider.of<ChatCubit>(context).currentTopicIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.topics.length,
      itemBuilder: (context, index) {
        return InkWell(
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) {
                return CustomRemoveAlertDialog(topic: widget.topics[index]);
              },
            );
          },
          onTap: () {
            setState(() {
              this.index = index;
              BlocProvider.of<ChatCubit>(context).changeTopic(index);
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: this.index != index
                  ? Colors.grey.withOpacity(0.2)
                  : kSecondaryColor2,
              border:
                  Border.all(color: Colors.white.withOpacity(0.3), width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                widget.topics[index].title!,
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


