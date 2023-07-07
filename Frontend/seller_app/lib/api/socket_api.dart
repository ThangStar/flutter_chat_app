import 'package:seller_app/constants/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketInstance {
  late IO.Socket socket;

  SocketInstance() {
    socket = IO.io(
        Constants.SOCKET_URL,
        OptionBuilder().setTransports(['websocket']).setQuery(
            {'username': 'username'}).build());
  }
}
