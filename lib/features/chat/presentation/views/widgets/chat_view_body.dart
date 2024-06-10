import 'package:flutter/material.dart';
import 'package:intellichat/features/chat/presentation/views/widgets/custom_dash_chat.dart';

import '../../data/models/topic_model/topic.dart';

class ChatViewBody extends StatelessWidget {
  const ChatViewBody({super.key, this.topic});

  final Topic? topic;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              Expanded(
                child: CustomDashChat(
                  topic: topic,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
