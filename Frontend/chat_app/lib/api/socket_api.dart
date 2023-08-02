import 'package:seller_app/constants/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketInstance {
  final int id;
  late IO.Socket socket;
  SocketInstance({required this.id}) {
    socket = IO.io(
        Constants.SOCKET_URL,
        OptionBuilder()
            .disableForceNewConnection()
            .disableForceNew()
            .setTransports(['websocket']).setQuery({'myId': id}).build());
  }
}

class SocketApi {
  static int id = 0;
  late IO.Socket socket;
  // A static private instance to access _socketApi from inside class only
  static final SocketApi _socketApi = SocketApi._internal();

  // An internal private constructor to access it for only once for static instance of class.
  SocketApi._internal() {
    print("socket created");
    socket = IO.io(
        Constants.SOCKET_URL ?? "http://localhost:3001",
        OptionBuilder()
            .disableForceNewConnection()
            .disableForceNew()
            .setTransports(['websocket']).setQuery({'myId': id}).build());
  }

  // Factry constructor to retutrn same static instance everytime you create any object.
  factory SocketApi(int id) {
    SocketApi.id = id;
    return _socketApi;
  }

// All socket related functions.
}
