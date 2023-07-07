import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:seller_app/model/profile.dart';
import 'package:seller_app/storages/storage.dart';

import '../../../api/socket_api.dart';
import '../../../model/message.dart';

part 'message_event.dart';

part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(const MessageState()) {
    on<HandleActionSend>(_handleActionSend);
    on<HandleActionAddMessageFromServer>(_handleActionAddMessageFromServer);

  }

  FutureOr<void> _handleActionSend(
      HandleActionSend event, Emitter<MessageState> emit) async {
    String myProfile = await Storage.getMyProfile() ?? "";
    Profile profile = Profile.fromRawJson(myProfile);

    Message message = Message(
        message: event.txtMessage,
        idUserGet: event.idUserChatting,
        idUserSend: profile.id.toString());
    emit(MessageState(messages: [...state.messages, message]));

    IO.Socket _socket = SocketInstance(id: profile.id).socket;
    _socket.emit("messageFromClient",
        {'message': event.txtMessage, 'idUserGet': profile.id, 'idUserSend': event.idUserChatting});
  }

  FutureOr<void> _handleActionAddMessageFromServer(HandleActionAddMessageFromServer event, Emitter<MessageState> emit) {
    emit(MessageState(messages: [...state.messages, event.message]));
  }
}
