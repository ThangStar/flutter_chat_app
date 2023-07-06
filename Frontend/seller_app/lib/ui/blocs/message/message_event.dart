part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class HandleActionSend extends MessageEvent{
  final String txtMessage;

  HandleActionSend({required this.txtMessage});
}
