import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketInstance {
  late IO.Socket socket;

  SocketInstance() {
    socket = IO.io(
        'http://192.168.1.16:3001',
        OptionBuilder().setTransports(['websocket']).setQuery(
            {'username': 'username'}).build());
  }
}
