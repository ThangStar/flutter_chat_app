part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [HandleActionSend, HandleActionAddMessageFromServer, ConnectToSocket, MessageInitialEvent];
}

class HandleActionSend extends MessageEvent {
  final String txtMessage;
  final String idUserChatting;
  final String? dateTime;

  const HandleActionSend(
      {required this.idUserChatting, required this.txtMessage, this.dateTime});
}

class HandleActionAddMessageFromServer extends MessageEvent{
  final Message message;

  const HandleActionAddMessageFromServer({required this.message});
}

class ConnectToSocket extends MessageEvent{
  
}
class MessageInitialEvent extends MessageEvent{}

class HandleActionSendImageMessage extends MessageEvent{
}