part of 'message_bloc.dart';

class MessageState extends Equatable {
  final List<Message> messages;

  const MessageState({this.messages = const []});

  @override
  List<Object> get props => [messages];
}
