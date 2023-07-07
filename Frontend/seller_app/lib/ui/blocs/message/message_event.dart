part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HandleActionSend extends MessageEvent {
  final String txtMessage;
  final String idUserChatting;

  const HandleActionSend(
      {required this.idUserChatting, required this.txtMessage});
}

class HandleActionAddMessageFromServer extends MessageEvent{
  final Message message;

  HandleActionAddMessageFromServer({required this.message});
}
