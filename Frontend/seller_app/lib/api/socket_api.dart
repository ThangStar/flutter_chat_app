import 'package:seller_app/constants/constants.dart';
import 'package:seller_app/model/profile.dart';
import 'package:seller_app/storages/storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketInstance {
  late IO.Socket socket;
  final int id;
  SocketInstance({required this.id}) {

    socket = IO.io(
        Constants.SOCKET_URL,
        OptionBuilder().setTransports(['websocket']).setQuery(
            {'myId': id}).build());




  }
}
