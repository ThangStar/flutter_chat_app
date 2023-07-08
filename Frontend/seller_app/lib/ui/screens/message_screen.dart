import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app/model/person_chatted.dart';
import 'package:seller_app/ui/blocs/person_chated/person_chatted_bloc.dart';
import 'package:seller_app/ui/screens/chat_screen.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';
import 'package:seller_app/ui/widgets/my_action_button.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../api/socket_api.dart';
import '../../model/message.dart';
import '../../model/profile.dart';
import '../../storages/storage.dart';
import '../blocs/message/message_bloc.dart';
import '../widgets/avatar_message.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<MessageScreen> {
  late PersonChattedBloc _chattedBloc;
  String username = "";
  late MessageBloc messageBloc;

  _newChat() {
    print('new chat');
  }

  @override
  void initState() {
    super.initState();
    messageBloc = BlocProvider.of<MessageBloc>(context);

    Storage.getMyProfile().then((value) {
      Profile prf = Profile.fromRawJson(value ?? "");
      setState(() {
        username = prf.username;
      });

      // TODO: implement initState
      _chattedBloc = BlocProvider.of<PersonChattedBloc>(context);
      _chattedBloc.add(InitPersonChatted());

      IO.Socket socket = SocketApi(prf.id).socket;
      if (!socket.hasListeners("messageFromServer")) {
        socket.on("messageFromServer", (data) async {
          Message message = Message.fromJson(data);

          messageBloc.add(HandleActionAddMessageFromServer(message: message));
        });
      }
    });
  }

  // Storage.getMyProfile().then((profile) {
  //   Profile prf = Profile.fromRawJson(profile ?? "");
  //   int myid = prf.id;
  //   IO.Socket _socket = SocketInstance(id: myid).socket;
  //
  //   if (_socket.connected) {
  //     _socket.on("messageFromServer", (data) {
  //       Message message = Message.fromJson(data);
  //       print(message);
  //       // messageBloc.add(HandleActionAddMessageFromServer(message: message));
  //       // setState(() {
  //       //   messages = [...messages, message];
  //       // });
  //     });
  //   } else {
  //     print("socket connect failure");
  //   }
  // });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorScheme(context).secondary,
        onPressed: () {},
        child: Icon(color: colorScheme(context).onPrimary, Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: colorScheme(context).background,
        toolbarHeight: 100,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Chào ${username},",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colorScheme(context).scrim.withOpacity(0.6)
              ),
            ),
            Text("Tin nhắn",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          MyActionButton(onPressed: () {  }, icon: Icons.search,)
        ],
      ),
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          children: [
            Divider(
              thickness: 4,
              color: colorScheme(context).tertiary.withOpacity(0.3),
            ),
            const SizedBox(
              height: 18,
            ),
            const NearUserChatted(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                color: colorScheme(context).tertiary.withOpacity(0.3),
              ),
            ),
            const ChatContent()
          ],
        ),
      ),
    );
  }
}

class ChatContent extends StatefulWidget {
  const ChatContent({super.key});

  @override
  State<ChatContent> createState() => _ChatContentState();
}

class _ChatContentState extends State<ChatContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<PersonChattedBloc, PersonChattedState>(
        builder: (context, state) {
          return ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                PersonChatted person = state.persons[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                              idUserChatting: person.id,
                              fullNameUserChatting: person.username),
                        ));
                  },
                  trailing: Text(
                    person.dateTime,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 15,
                        color: colorScheme(context).scrim.withOpacity(0.4)),
                  ),
                  leading: Image.asset(
                    width: 62,
                    height: 62,
                    'assets/images/avatar.png',
                  ),
                  title: Text(
                    person.username,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  subtitle: Text(
                    person.message,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: colorScheme(context).scrim.withOpacity(0.4),  fontSize: 15),
                  ),
                );
              },
              separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(
                      color: colorScheme(context).tertiary.withOpacity(0.3),
                    ),
                  ),
              itemCount: state.persons.length);
        },
      ),
    );
    ;
  }
}

class NearUserChatted extends StatelessWidget {
  const NearUserChatted({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: BlocBuilder<PersonChattedBloc, PersonChattedState>(
        builder: (context, state) {
          return ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 18,
                );
              },
              itemCount: state.persons.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                PersonChatted person = state.persons[index];
                return Row(
                  children: [
                    const SizedBox(
                      width: 18,
                    ),
                    avatarMessage(person.username, context),
                  ],
                );
              });
        },
      ),
    );
  }
}
