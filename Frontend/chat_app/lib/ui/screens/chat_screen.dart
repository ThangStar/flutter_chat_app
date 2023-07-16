import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seller_app/storages/storage.dart';
import 'package:seller_app/ui/blocs/message/message_bloc.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';
import 'package:seller_app/ui/widgets/message_chat.dart';
import 'package:seller_app/utils/spacing_date_to_now.dart';

import '../../api/socket_api.dart';
import '../../model/message.dart';
import '../../model/profile.dart';
import '../widgets/container_chat.dart';
import '../widgets/my_action_button.dart';
import '../widgets/online_icon.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  final String avatarUrl;
  final int idUserChatting;
  final String fullNameUserChatting;

  const ChatScreen(
      {super.key,
      required this.idUserChatting,
      required this.fullNameUserChatting,
      required this.avatarUrl});

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
    Storage.saveUserCurrentProfile(widget.idUserChatting.toString());

    Storage.getMyProfile().then((value) {
      Profile profile = Profile.fromRawJson(value ?? "");

      IO.Socket _socket = SocketApi(profile.id).socket;
      _socket.emit("requestMessagesFromClient", {
        "idUserSend": profile.id,
        "idUserGet": widget.idUserChatting,
      });

      if (!_socket.hasListeners("messages")) {
        _socket.on("messages", (data) async {
          print(data.runtimeType);
          // final listDynamic = jsonDecode(res.body) as List<dynamic>;
          // final posts = listDynamic.map((e) => Post.fromJson(e)).toList();
          final messagesJson = data as List<dynamic>;
          List<Message> messages = [];

          messagesJson.forEach((e) {
            print(Message.fromJson(e).dateTime);
            messages.add(Message.fromJson(e));
          });
          messageBloc.add(InitDataMessagesEvent(messages: messages));
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    Storage.saveUserCurrentProfile("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(backgroundImage: NetworkImage(widget.avatarUrl)),
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
                      Row(
                        children: [
                          OnlineIcon(),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Đang hoạt động',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w100,
                                    color: colorScheme(context)
                                        .scrim
                                        .withOpacity(0.6)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            MyActionButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/svg/voice_call.svg',
                color: colorScheme(context).scrim,
              ),
            ),
            MyActionButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/svg/video_call.svg',
                  color: colorScheme(context).scrim),
            ),
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
                          _scrollController.position.maxScrollExtent * 2,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.bounceIn);
                    } else if (state is InitMessageFinishState) {
                      _scrollController
                          .jumpTo(_scrollController.position.maxScrollExtent);
                    }
                  },
                  builder: (context, state) {
                    return ListView.separated(
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          Message message = state.messages[index];
                          return MessageChat(
                              message: message.message,
                              dateTime: spacingDateToNow(
                                  DateTime.parse(message.dateTime ?? "")),
                              isMyMessage:
                                  message.idUserSend != widget.idUserChatting);
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
                child: ContainerChat(onTapImage: () {
                  context
                      .read<MessageBloc>()
                      .add(HandleActionSendImageMessage());
                }, handleActionSend: (txtMessage) {
                  print(txtMessage);
                  context.read<MessageBloc>().add(HandleActionSend(
                        dateTime: DateTime.now().toIso8601String(),
                        idUserChatting: widget.idUserChatting,
                        txtMessage: txtMessage,
                      ));
                }))
          ],
        ));
  }
}
