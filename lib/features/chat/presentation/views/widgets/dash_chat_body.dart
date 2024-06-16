import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intellichat/core/media/media_seervice.dart';
import 'package:intellichat/core/router/app_router.dart';
import 'package:intellichat/core/utils/assets_data.dart';
import 'package:intellichat/features/chat/presentation/views/widgets/custom_scroll_to_bottom_button.dart';
import 'package:intellichat/features/chat/presentation/views/widgets/welcome_widget.dart';

import '../../../../../constants.dart';
import '../../../../../core/utils/widgets/custom_spinkit.dart';
import '../../../../../core/utils/widgets/my_behavior.dart';
import '../../../../../core/utils/widgets/show_snack_bar.dart';
import '../../../../auth/presentation/logic/login_cubit/login_cubit.dart';
import '../../logic/chat_cubit/chat_cubit.dart';
import 'custom_send_button_builder.dart';

class DashChatBody extends StatefulWidget {
  const DashChatBody({
    super.key,
    required this.currentTopicID,
  });

  final String currentTopicID;

  @override
  State<DashChatBody> createState() => _DashChatBodyState();
}

class _DashChatBodyState extends State<DashChatBody> {
  final ChatUser _currernUser = ChatUser(
    id: FirebaseAuth.instance.currentUser!.uid,
    firstName: FirebaseAuth.instance.currentUser!.displayName,
  );
  final ChatUser _geminiChatBot = ChatUser(
    id: '2',
    firstName: 'IntelliChat',
    profileImage: AssetsData.kRobotPic,
  );
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _messageController = TextEditingController();
  final List<ChatUser> _typingUsers = [];
  final MediaService _mediaService = MediaService();
  File? _image;

  @override
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLogoutSuccess) {
          AppRouter.pushReplacementAll(view: AppRouter.kLoginView);
        }
      },
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: BlocConsumer<ChatCubit, ChatState>(
          builder: (context, state) {
            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(kUserCollection)
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection(kTopicsCollection)
                  .doc(widget.currentTopicID)
                  .collection(kMessagesCollection)
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _messages.clear();
                  for (QueryDocumentSnapshot doc in snapshot.data!.docs) {
                    Timestamp timestamp = doc['createdAt'] as Timestamp;
                    DateTime dateTime = timestamp.toDate();
                    List<ChatMedia>? medias = [];
                    var x = doc.data() as Map<String, dynamic>;
                    if (x.containsKey('imageURL')) {
                      var imageURL = doc['imageURL'];
                      if (imageURL != null) {
                        medias.add(
                          ChatMedia(
                            url: imageURL,
                            fileName: '',
                            type: MediaType.image,
                          ),
                        );
                      }
                    }
                    _messages.add(
                      ChatMessage(
                        user: doc['userID'] ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? _currernUser
                            : _geminiChatBot,
                        createdAt: dateTime,
                        text: doc['message'],
                        medias: medias,
                      ),
                    );
                  }
                  return Stack(
                    children: [
                      if (_messages.isEmpty) const WelcomeWidget(),
                      DashChat(
                        scrollToBottomOptions: ScrollToBottomOptions(
                          scrollToBottomBuilder: (scrollController) {
                            return CustomScrollToBottomButton(
                                scrollController: scrollController);
                          },
                        ),
                        typingUsers: _typingUsers,
                        messageListOptions: const MessageListOptions(
                          showDateSeparator: false,
                        ),
                        messageOptions: MessageOptions(
                          messageMediaBuilder: (ChatMessage message,
                              ChatMessage? previousMessage,
                              ChatMessage? nextMessage) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: message.medias!.first.url,
                                  placeholder: (context, text) {
                                    return const SpinKitPulse(
                                      color: kSecondaryColor2,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                          showTime: true,
                          showOtherUsersName: true,
                          onLongPressMessage: (chatMessage) {
                            Clipboard.setData(
                                ClipboardData(text: chatMessage.text));
                            showSnackBar(context,
                                message: 'Message copied to clipboard',
                                backgroundColor: Colors.green.shade400);
                          },
                          containerColor: kSecondaryColor,
                          textColor: Colors.white,
                          currentUserTextColor: Colors.white,
                          currentUserContainerColor: kSecondaryColor2,
                        ),
                        inputOptions: InputOptions(
                          trailing: [_mediaMessageButton()],
                          alwaysShowSend: true,
                          sendButtonBuilder: (onSend) {
                            return SendButtonBuilder(
                              onTap: onSend,
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
                          if (BlocProvider.of<LoginCubit>(context)
                              .networkConnection) {
                            getChatResponse(
                              chatMessage: chatMessage,
                              topicID: widget.currentTopicID,
                            );
                          } else {
                            showSnackBar(context, message: kNoInternetMessage);
                          }
                        },
                        messages: _messages,
                      ),
                    ],
                  );
                } else {
                  return const CustomSpinkKit();
                }
              },
            );
          },
          listener: (BuildContext context, ChatState state) {
            if (state is ChatNewChatSuccess ||
                state is ChatFetchMessagesSuccess) {
              setState(() {});
            }
            if (state is ChatGeminiLoading) {
              _typingUsers.add(_geminiChatBot);
            } else {
              _typingUsers.clear();
            }
          },
        ),
      ),
    );
  }

  Widget _mediaMessageButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: InkWell(
        onTap: () async {
          _image = await _mediaService.getImageFromGallery();
          setState(() {});
        },
        child: _image == null
            ? Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kSecondaryColor,
                ),
                child: const Icon(
                  FontAwesomeIcons.image,
                  color: kSecondaryColor2,
                ),
              )
            : Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Image.file(
                      _image!,
                      width: 30,
                    ),
                  ),
                  Positioned(
                    left: 8,
                    child: InkWell(
                        onTap: () {
                          _image = null;
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 22,
                        )),
                  ),
                ],
              ),
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
      {required ChatMessage chatMessage, required String topicID}) async {
    if (_image != null) {
      String path = _image!.path;
      List<String> pathSegments = path.split('/');
      chatMessage.medias = [
        ChatMedia(
            url: _image!.path,
            fileName: pathSegments.last,
            type: MediaType.image)
      ];
      setState(
        () {
          _image = null;
        },
      );
    }
    await BlocProvider.of<ChatCubit>(context).sendMessage(
        firebaseUser: FirebaseAuth.instance.currentUser!,
        topicID: topicID,
        message: chatMessage);
    List<Content> chatHistory = [];
    for (var message in _messages.reversed) {
      if (message.user == _currernUser) {
        chatHistory.add(Content.text(message.text));
      } else {
        chatHistory.add(Content.model([TextPart(message.text)]));
      }
    }
    await BlocProvider.of<ChatCubit>(context).generateResponse(
        firebaseUser: FirebaseAuth.instance.currentUser!,
        topicID: topicID,
        chatMessage: chatMessage,
        geminiChatBot: _geminiChatBot,
        chatHistory: chatHistory);
  }
}
