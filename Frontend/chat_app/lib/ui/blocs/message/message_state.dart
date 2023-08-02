part of 'message_bloc.dart';

class MessageState extends Equatable {
  final List<Message> messages;

  const MessageState({required this.messages});

  @override
  List<Object> get props => [messages];
}

class NewMessageState extends MessageState {
  const NewMessageState({required super.messages});
}

class MessageLoadingState extends MessageState {
  const MessageLoadingState({required super.messages});
}

class InitMessageFinishState extends MessageState {
  const InitMessageFinishState({required super.messages});
}
