import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:seller_app/api/socket_api.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

part 'message_event.dart';

part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessageInitial()) {
    on<HandleActionSend>(_handleActionSend);
  }

  FutureOr<void> _handleActionSend(
      HandleActionSend event, Emitter<MessageState> emit) {
    IO.Socket _socket = SocketInstance().socket;
    _socket.emit("messageFromClient",
        {'message': event.txtMessage, 'idUserGet': 'id1', 'idUserSend': "id2"});
  }
}
