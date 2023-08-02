import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app/ui/screens/login_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../blocs/message/message_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late IO.Socket _socket;
  late MessageBloc messageBloc;

  @override
  void initState() {
    messageBloc = BlocProvider.of<MessageBloc>(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SPLASH SCREEN"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ));
            },
            child: const Text("ISJFIOA")),
      ),
    );
  }
}
