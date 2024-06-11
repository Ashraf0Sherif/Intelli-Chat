import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intellichat/features/chat/presentation/views/widgets/welcome_widget.dart';

import '../../../../../constants.dart';
import '../../../../../core/utils/widgets/my_behavior.dart';
import '../../../../auth/presentation/logic/login_cubit/login_cubit.dart';
import '../../logic/chat_cubit/chat_cubit.dart';

class DashChatBody extends StatefulWidget {
  const DashChatBody({super.key});

  @override
  State<DashChatBody> createState() => _DashChatBodyState();
}

class _DashChatBodyState extends State<DashChatBody> {
  final ChatUser _currernUser = ChatUser(
      id: FirebaseAuth.instance.currentUser == null
          ? '1'
          : FirebaseAuth.instance.currentUser!.uid,
      firstName: FirebaseAuth.instance.currentUser == null
          ? ''
          : FirebaseAuth.instance.currentUser!.displayName);
  final ChatUser _geminiChatBot =
      ChatUser(id: '2', firstName: 'Intelli', lastName: '-Chat');
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: BlocConsumer<ChatCubit, ChatState>(
        builder: (context, state) {
          int currentIndex =
              BlocProvider.of<ChatCubit>(context).currentTopicIndex;
          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection(kUserCollection)
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection(kTopicsCollection)
                .doc(BlocProvider.of<LoginCubit>(context)
                    .user!
                    .topics![currentIndex]
                    .id)
                .collection(kMessagesCollection)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _messages.clear();
                for (var doc in snapshot.data!.docs) {
                  Timestamp timestamp = doc['createdAt'] as Timestamp;
                  DateTime dateTime = timestamp.toDate();
                  _messages.add(
                    ChatMessage(
                      user: _currernUser,
                      createdAt: dateTime,
                      text: doc['message'],
                    ),
                  );
                }
                return Column(
                  children: [
                    if (_messages.isEmpty)
                      const Expanded(child: WelcomeWidget()),
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
                          getChatResponse(
                            chatMessage: chatMessage,
                            topicID: BlocProvider.of<LoginCubit>(context)
                                .user!
                                .topics![currentIndex]
                                .id!,
                          );
                        },
                        messages: _messages,
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                );
              }
            },
          );
        },
        listener: (BuildContext context, ChatState state) {
          if (state is ChatNewChatSuccess ||
              state is ChatFetchMessagesSuccess) {
            setState(() {});
          }
        },
      ),
    );
  }

  OutlineInputBorder buildBorder({Color color = Colors.grey}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: color, width: 1.4),
    );
  }

  void getChatResponse(
      {required ChatMessage chatMessage, required String topicID}) {
    BlocProvider.of<ChatCubit>(context).sendMessage(
        firebaseUser: FirebaseAuth.instance.currentUser!,
        topicID: topicID,
        message: chatMessage);
  }
}
