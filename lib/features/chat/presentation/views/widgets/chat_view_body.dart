import 'package:flutter/material.dart';
import 'package:intellichat/features/chat/presentation/views/widgets/custom_dash_chat.dart';

class ChatViewBody extends StatelessWidget {
  const ChatViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              Expanded(child: CustomDashChat()),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
