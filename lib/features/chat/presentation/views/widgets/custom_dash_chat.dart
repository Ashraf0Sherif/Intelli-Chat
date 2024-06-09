import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intellichat/core/utils/widgets/my_behavior.dart';
import 'package:intellichat/features/chat/presentation/views/widgets/not_logged_in.dart';

import '../../../../../constants.dart';

class CustomDashChat extends StatefulWidget {
  const CustomDashChat({super.key});

  @override
  State<CustomDashChat> createState() => _CustomDashChatState();
}

class _CustomDashChatState extends State<CustomDashChat> {
  final ChatUser _currernUser = ChatUser(
      id: FirebaseAuth.instance.currentUser == null
          ? '1'
          : FirebaseAuth.instance.currentUser!.uid,
      firstName: FirebaseAuth.instance.currentUser == null
          ? ''
          : FirebaseAuth.instance.currentUser!.displayName);
  final ChatUser _geminiChatBot =
      ChatUser(id: '2', firstName: 'Intelli', lastName: '-Chat');
  List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _messageController = TextEditingController();

  OutlineInputBorder buildBorder({Color color = Colors.grey}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: color, width: 1.4),
    );
  }
  @override
  void initState() {
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: Column(
        children: [
          if (_messages.isEmpty) const Expanded(child: WelcomeWidget()),
          Expanded(
            child: DashChat(
              messageListOptions: const MessageListOptions(
                showDateSeparator: false,
              ),
              messageOptions: const MessageOptions(
                containerColor: kSecondaryColor,
                textColor: Colors.white,
                currentUserTextColor: kPrimaryColor,
                currentUserContainerColor: kSecondaryColor2,
              ),
              inputOptions: InputOptions(
                sendButtonBuilder: (onSend) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: InkWell(
                      onTap: onSend,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kSecondaryColor,
                        ),
                        child: const Icon(
                          FontAwesomeIcons.paperPlane,
                          color: kSecondaryColor2,
                        ),
                      ),
                    ),
                  );
                },
                textController: _messageController,
                inputDecoration: InputDecoration(
                  filled: true,
                  fillColor: kSecondaryColor.withOpacity(0.3),
                  contentPadding: const EdgeInsets.all(15),
                  enabledBorder: buildBorder(),
                  focusedBorder: buildBorder(),
                  border: buildBorder(),
                  hintText: "Ask me anything",
                ),
              ),
              currentUser: _currernUser,
              onSend: (ChatMessage chatMessage) {
                getChatResponse(chatMessage);
              },
              messages: _messages,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage chatMessage) async {
    setState(
      () {
        _messages.insert(0, chatMessage);
      },
    );
  }
}
