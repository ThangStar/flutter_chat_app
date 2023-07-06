import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app/ui/blocs/message/message_bloc.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';
import 'package:seller_app/ui/widgets/message_chat.dart';

import '../../api/socket_api.dart';
import '../../model/message.dart';
import '../widgets/container_chat.dart';
import 'package:seller_app/api/socket_api.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> messages = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IO.Socket _socket = SocketInstance().socket;
    _socket.on("messageFromServer", (data){
      Message message = Message.fromJson(data);
      setState(() {
        messages = [...messages, message];
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {

    MessageBloc messageBloc = BlocProvider.of<MessageBloc>(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(double.infinity),
                    child: Image.asset(
                      'assets/images/avatar.png',
                      width: 52,
                      height: 52,
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Elon Tusk",
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text(
                        'Đang hoạt động',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(
                            fontWeight: FontWeight.w100,
                            color: colorScheme(context).scrim.withOpacity(0.6)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
                color: colorScheme(context).tertiary,
                onPressed: () {},
                icon: Icon(
                  Icons.call,
                  color: colorScheme(context).scrim,
                )),
            IconButton(
                color: colorScheme(context).tertiary,
                onPressed: () {},
                icon: Icon(
                  Icons.call,
                  color: colorScheme(context).scrim,
                ))
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 22,),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      Message ms = messages[index];
                      return MessageChat(
                          message: ms.message,
                          dateTime: "1 phút trước",
                          isMyMessage: ms.idUserSend == "abc");
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(
                          height: 12,
                        ),
                    itemCount: messages.length),
              ),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: ContainerChat(handleActionSend: (txtMessage) =>
                messageBloc..add(HandleActionSend(txtMessage: txtMessage))
                ))
          ],
        ));
  }
}
