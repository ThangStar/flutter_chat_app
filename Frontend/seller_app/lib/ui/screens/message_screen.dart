import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app/model/person_chatted.dart';
import 'package:seller_app/ui/blocs/person_chated/person_chatted_bloc.dart';
import 'package:seller_app/ui/screens/chat_screen.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';

import '../widgets/avatar_message.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<MessageScreen> {
  late PersonChattedBloc _chattedBloc;
  List<PersonChatted> persons = [
    PersonChatted(id: 1, message: "1", username: "2", dateTime: "2")
  ];

  _newChat() {
    print('new chat');
  }

  @override
  void initState() {
    super.initState();
    _chattedBloc = BlocProvider.of<PersonChattedBloc>(context);
    _chattedBloc.add(InitPersonChatted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorScheme(context).secondary,
        onPressed: () {},
        child: Icon(color: colorScheme(context).onPrimary, Icons.add),
      ),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Chào Alex,",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text("Tin nhắn",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
              onPressed: _newChat,
              icon: const Icon(Icons.add_circle_outline_rounded))
        ],
      ),
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          children: [
            const SizedBox(
              height: 18,
            ),
            const NearUserChatted(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child:
                  Divider(color: colorScheme(context).scrim.withOpacity(0.1)),
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
                          builder: (context) => ChatScreen(idUserChatting: person.id, fullNameUserChatting: person.username),
                        ));
                  },
                  trailing: Text(
                    person.dateTime,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: colorScheme(context).scrim.withOpacity(0.6)),
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
                        color: colorScheme(context).scrim.withOpacity(0.6)),
                  ),
                );
              },
              separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(
                        color: colorScheme(context).scrim.withOpacity(0.1)),
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
      height: 120,
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
                    avatarMessage(person.username,context),
                  ],
                );
              });
        },
      ),
    );
  }
}
