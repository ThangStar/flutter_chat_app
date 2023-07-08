import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app/ui/blocs/message/message_bloc.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';
import 'package:seller_app/ui/widgets/message_chat.dart';

import '../../model/message.dart';
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
  late MessageBloc messageBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    messageBloc = BlocProvider.of<MessageBloc>(context);
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
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
                child: BlocConsumer<MessageBloc, MessageState>(
                  listener: (context, state) {
                    if (state is NewMessageState) {
                      print("NewMessageState");
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent*2,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.bounceIn);
                    }
                  },
                  builder: (context, state) {
                    return ListView.separated(
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          Message message = state.messages[index];
                          return MessageChat(
                              message: message.message,
                              dateTime: message.idUserSend,
                              isMyMessage: message.idUserSend !=
                                  widget.idUserChatting.toString());
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
                child: ContainerChat(handleActionSend: (txtMessage) {
                  print(txtMessage);

                  context.read<MessageBloc>().add(HandleActionSend(
                        idUserChatting: widget.idUserChatting.toString(),
                        txtMessage: txtMessage,
                      ));
                }))
          ],
        ));
  }
}
