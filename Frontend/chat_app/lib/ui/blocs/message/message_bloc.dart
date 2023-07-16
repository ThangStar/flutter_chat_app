import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_app/api/api.dart';
import 'package:seller_app/model/profile.dart';
import 'package:seller_app/storages/storage.dart';
import 'package:seller_app/utils/spacing_date_to_now.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../api/socket_api.dart';
import '../../../model/message.dart';
import '../../../utils/image_picker.dart';

part 'message_event.dart';

part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(const MessageState(messages: [])) {
    on<HandleActionSend>(_handleActionSend);
    on<HandleActionAddMessageFromServer>(_handleActionAddMessageFromServer);
    on<HandleActionSendImageMessage>(_handleActionSendImageMessage);
    on<InitDataMessagesEvent>(_initDataMessagesEvent);
  }

  FutureOr<void> _handleActionSend(
      HandleActionSend event, Emitter<MessageState> emit) async {
    emit(MessageLoadingState(messages: state.messages));
    print(event.txtMessage);

    Storage.getMyProfile().then((value) {
      Profile profile = Profile.fromRawJson(value ?? "");
      Message message = Message(
          message: event.txtMessage,
          idUserGet: event.idUserChatting,
          dateTime: DateTime.now().toIso8601String(),
          idUserSend: profile.id);
      print("message: ${state.messages.length}");
      emit(MessageState(messages: [...state.messages, message]));
      emit(NewMessageState(messages: state.messages));

      //
      IO.Socket _socket = SocketApi(profile.id).socket;
      if (_socket.connected) {
        _socket.emit("messageFromClient", {
          'message': event.txtMessage,
          'idUserGet': event.idUserChatting,
          'idUserSend': profile.id,
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
    emit(MessageState(messages: [...state.messages, event.message]));
    emit(NewMessageState(messages: state.messages));
  }

  FutureOr<void> _handleActionSendImageMessage(
      HandleActionSendImageMessage event, Emitter<MessageState> emit) async {
    XFile? image = await pickerImage();
    Api.emitImageSocket(image);
    // emit(MessageLoadingState(messages: state.messages));
  }

  FutureOr<void> _initDataMessagesEvent(
      InitDataMessagesEvent event, Emitter<MessageState> emit) {
    emit(MessageState(messages: event.messages));
    emit(InitMessageFinishState(messages: state.messages));
  }
}
