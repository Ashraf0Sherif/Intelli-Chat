import 'package:bloc/bloc.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../../core/firebase/firebase_exceptions.dart';
import '../../../repos/chat_repo_implementation.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepoImplementation chatRepoImplementation;

  ChatCubit(this.chatRepoImplementation) : super(ChatInitial());

  Future<void> textGeneration({required String prompt}) async {
    emit(ChatLoading());
    var response = await chatRepoImplementation.textGeneration(prompt: prompt);
    if (response == null) {
      emit(ChatFailure("errorMessage"));
    } else {
      emit(ChatSuccess("geminiResponse"));
    }
  }

  Future<void> createTopic(
      {required User firebaseUser, required String title}) async {
    emit(ChatNewChatLoading());
    var response = await chatRepoImplementation.createTopic(
        firebaseUser: firebaseUser, title: title);
    response.when(
      success: (success) {
        emit(ChatNewChatSuccess());
      },
      failure: (FirebaseExceptions firebaseExceptions) {
        emit(ChatNewChatFailure(
            FirebaseExceptions.getErrorMessage(firebaseExceptions)));
      },
    );
  }

  Future<void> removeChat(
      {required User firebaseUser, required String topicID}) async {
    emit(ChatRemoveLoading());
    var response = await chatRepoImplementation.removeTopic(
        firebaseUser: firebaseUser, topicID: topicID);
    response.when(success: (success) {
      emit(ChatRemoveSuccess());
    }, failure: (FirebaseExceptions firebaseExceptions) {
      emit(ChatRemoveFailure(
          FirebaseExceptions.getErrorMessage(firebaseExceptions)));
    });
  }

  Future<void> sendMessage(
      {required User firebaseUser,
      required String topicID,
      required ChatMessage message}) async {
    emit(ChatSendMessageLoading());
    var response = await chatRepoImplementation.sendMessage(
        firebaseUser: firebaseUser, topicID: topicID, message: message);
    response.when(
      success: (t) {
        emit(ChatSendMessageSuccess());
      },
      failure: (error) {
        emit(ChatSendMessageFailure());
      },
    );
  }
}
