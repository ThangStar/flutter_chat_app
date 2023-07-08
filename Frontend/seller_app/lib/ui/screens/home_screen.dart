import 'package:flutter/material.dart';
import 'package:seller_app/api/socket_api.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // IO.Socket _socket = SocketInstance().socket;
  // _connectSocket() {
  //   _socket.onConnect((data) => print('Connection established'));
  //   _socket.onConnectError((data) => print('Connect Error: $data'));
  //   _socket.onDisconnect((data) => print('Socket.IO server disconnected'));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: (){

            }, child: Text("send message")),
      ),
    );
  }
}
