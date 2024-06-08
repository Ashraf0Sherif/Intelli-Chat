part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final String geminiResponse;

  ChatSuccess(this.geminiResponse);
}

class ChatFailure extends ChatState {
  final String errorMessage;

  ChatFailure(this.errorMessage);
}
