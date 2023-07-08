import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:seller_app/model/profile.dart';
import 'package:seller_app/storages/storage.dart';
import 'package:seller_app/utils/spacing_date_to_now.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../api/socket_api.dart';
import '../../../model/message.dart';

part 'message_event.dart';

part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(const MessageState(messages: [])) {
    on<HandleActionSend>(_handleActionSend);
    on<HandleActionAddMessageFromServer>(_handleActionAddMessageFromServer);
  }

  FutureOr<void> _handleActionSend(
      HandleActionSend event, Emitter<MessageState> emit) async {
    emit(MessageLoadingState(messages: state.messages));

    Storage.getMyProfile().then((value) {
      Profile profile = Profile.fromRawJson(value ?? "");
      Message message = Message(
          message: event.txtMessage,
          idUserGet: event.idUserChatting,
          dateTime: spacingDateToNow(DateTime.parse(event.dateTime ?? "")),
          idUserSend: profile.id.toString());
      print("message: ${state.messages.length}");
      emit(MessageState(messages: [...state.messages, message]));
      emit(NewMessageState(messages: state.messages));

      //
      IO.Socket _socket = SocketApi(profile.id).socket;
      if (_socket.connected) {
        _socket.emit("messageFromClient", {
          'message': event.txtMessage,
          'idUserGet': event.idUserChatting,
          'idUserSend': profile.id.toString(),
          'dateTime': DateTime.now().toIso8601String()
        });
      } else {
        print("connect socket failure");
      }
    });
  }

  FutureOr<void> _handleActionAddMessageFromServer(
      HandleActionAddMessageFromServer event, Emitter<MessageState> emit) {
    // emit(MessageLoadingState(messages: state.messages));
    String spacingTime = spacingDateToNow(DateTime.parse(event.message.dateTime ?? ""));
    event.message.dateTime = spacingTime;
    emit(MessageState(messages: [...state.messages, event.message]));
    emit(NewMessageState(messages: state.messages));
  }
}
