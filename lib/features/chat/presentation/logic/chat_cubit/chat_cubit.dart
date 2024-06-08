import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
}
