part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatRenameTopicLoading extends ChatState {}

class ChatRenameTopicFailure extends ChatState {
  final String errorMessage;

  ChatRenameTopicFailure(this.errorMessage);
}

class ChatRenameTopicSuccess extends ChatState {}

class ChatRemoveLoading extends ChatState {}

class ChatRemoveFailure extends ChatState {
  final String errorMessage;

  ChatRemoveFailure(this.errorMessage);
}

class ChatRemoveSuccess extends ChatState {}

class ChatNewChatLoading extends ChatState {}

class ChatNewChatSuccess extends ChatState {}

class ChatNewChatFailure extends ChatState {
  final String errorMessage;

  ChatNewChatFailure(this.errorMessage);
}

class ChatSendMessageLoading extends ChatState {}

class ChatSendMessageSuccess extends ChatState {}

class ChatSendMessageFailure extends ChatState {}

class ChatFetchMessagesFailure extends ChatState {}

class ChatFetchMessagesLoading extends ChatState {}

class ChatFetchMessagesSuccess extends ChatState {}

class ChatSuccess extends ChatState {
  final String geminiResponse;

  ChatSuccess(this.geminiResponse);
}

class ChatFailure extends ChatState {
  final String errorMessage;

  ChatFailure(this.errorMessage);
}
