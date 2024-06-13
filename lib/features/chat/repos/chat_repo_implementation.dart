

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../core/firebase/custom_firebase.dart';
import '../../../core/firebase/firebase_exceptions.dart';
import '../../../core/firebase/firebase_result.dart';
import '../../../core/gemini/custom_gemini.dart';
import 'chat_repo.dart';

class ChatRepoImplementation implements ChatRepo {
  final CustomGemini customGemini;
  final CustomFirebase customFirebase;

  ChatRepoImplementation(this.customGemini, this.customFirebase);

  @override
  Future<FirebaseResult<void>> sendMessage(
      {required User firebaseUser,
      required String topicID,
      required ChatMessage message}) async {
    try {
      await customFirebase.sendMessage(firebaseUser, topicID, message);
      return const FirebaseResult.success(null);
    } catch (error) {
      return FirebaseResult.failure(
          FirebaseExceptions.getFirebaseException(error));
    }
  }

  @override
  Future<FirebaseResult<void>> createTopic(
      {required User firebaseUser, required String title}) async {
    try {
      await customFirebase.createTopic(
          firebaseUser: firebaseUser, title: title);
      return const FirebaseResult.success(null);
    } catch (error) {
      return FirebaseResult.failure(
          FirebaseExceptions.getFirebaseException(error));
    }
  }

  @override
  Future<FirebaseResult<void>> removeTopic(
      {required User firebaseUser, required String topicID}) async {
    try {
      await customFirebase.removeTopic(
          firebaseUser: firebaseUser, topicID: topicID);
      return const FirebaseResult.success(null);
    } catch (error) {
      return FirebaseResult.failure(
          FirebaseExceptions.getFirebaseException(error));
    }
  }

  @override
  Future<FirebaseResult<void>> renameTopic(
      {required User firebaseUser,
      required String topicID,
      required String newTitle}) async {
    try {
      await customFirebase.renameTopic(
          firebaseUser: firebaseUser, topicID: topicID, newTitle: newTitle);
      return const FirebaseResult.success(null);
    } catch (error) {
      return FirebaseResult.failure(
          FirebaseExceptions.getFirebaseException(error));
    }
  }

  @override
  Future<FirebaseResult<void>> textGeneration(
      {required User firebaseUser,
      required String topicID,
      required String prompt,
      required ChatUser geminiChatBot,
      required List<Content> chatHistory}) async {
    try {
      final response = await customGemini.textGeneration(
          firebaseUser: firebaseUser,
          topicID: topicID,
          prompt: prompt,
          chatHistory: chatHistory);
      ChatMessage chatMessage = ChatMessage(
          user: geminiChatBot, createdAt: DateTime.now(), text: response ?? '');
      await sendMessage(
          firebaseUser: firebaseUser, topicID: topicID, message: chatMessage);
      return const FirebaseResult.success(null);
    } catch (error) {
      return FirebaseResult.failure(
          FirebaseExceptions.getFirebaseException(error));
    }
  }
}
