import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../core/firebase/firebase_result.dart';

abstract class ChatRepo {
  Future<FirebaseResult<void>> textGeneration(
      {required User firebaseUser,
      required String topicID,
      required ChatMessage message,
      required ChatUser geminiChatBot,required List<Content> chatHistory});

  Future<FirebaseResult<void>> createTopic(
      {required User firebaseUser, required String title});

  Future<FirebaseResult<void>> removeTopic(
      {required User firebaseUser, required String topicID});

  Future<FirebaseResult<void>> renameTopic(
      {required User firebaseUser,
      required String topicID,
      required String newTitle});

  Future<FirebaseResult<void>> sendMessage(
      {required User firebaseUser,
      required String topicID,
      required ChatMessage message});
}
