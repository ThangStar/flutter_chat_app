import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app/ui/blocs/message/message_bloc.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';
import 'package:seller_app/ui/widgets/message_chat.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../api/socket_api.dart';
import '../../model/message.dart';
import '../../model/profile.dart';
import '../../storages/storage.dart';
import '../widgets/container_chat.dart';

class ChatScreen extends StatefulWidget {
  final int idUserChatting;
  final String fullNameUserChatting;

  const ChatScreen(
      {super.key,
      required this.idUserChatting,
      required this.fullNameUserChatting});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> messages = [];
  late MessageBloc messageBloc;

  @override
  void initState() {
    IO.Socket _socket;
    super.initState();
    messageBloc = BlocProvider.of<MessageBloc>(context);
    int myid = 0;
    Storage.getMyProfile().then((profile) {
      Profile prf = Profile.fromRawJson(profile ?? "");
      myid = prf.id;
      _socket = SocketInstance(id: myid).socket;
      if (_socket.connected) {
        _socket.on("messageFromServer", (data) {
          Message message = Message.fromJson(data);
          messageBloc.add(HandleActionAddMessageFromServer(message: message));
          // setState(() {
          //   messages = [...messages, message];
          // });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        widget.fullNameUserChatting,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text(
                        'Đang hoạt động',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
            SizedBox(
              height: 22,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: BlocBuilder<MessageBloc, MessageState>(
                  builder: (context, state) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          Message message = state.messages[index];
                          return MessageChat(
                              message: message.message,
                              dateTime: message.message,
                              isMyMessage: message != widget.idUserChatting);
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 12,
                            ),
                        itemCount: state.messages.length);
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ContainerChat(
                  handleActionSend: (txtMessage) => messageBloc
                    ..add(HandleActionSend(
                      idUserChatting: widget.idUserChatting.toString(),
                      txtMessage: txtMessage,
                    ))),
            )
          ],
        ));
  }
}
