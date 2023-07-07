import 'package:flutter/material.dart';
import 'package:seller_app/model/person_chatted.dart';
import 'package:seller_app/ui/screens/chat_screen.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';

import '../widgets/avatar_message.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<MessageScreen> {
  List<PersonChatted> persons = [
    PersonChatted(
        avatar: "",
        username: 'username',
        finalMessage: 'hello',
        dateTime: '12h30p'),
    PersonChatted(
        avatar: "",
        username: 'username',
        finalMessage: 'hello',
        dateTime: '12h30p'),
    PersonChatted(
        avatar: "",
        username: 'username',
        finalMessage: 'hello',
        dateTime: '12h30p'),
    PersonChatted(
        avatar: "",
        username: 'username',
        finalMessage: 'hello',
        dateTime: '12h30p'),
    PersonChatted(
        avatar: "",
        username: 'username',
        finalMessage: 'hello',
        dateTime: '12h30p'),
    PersonChatted(
        avatar: "",
        username: 'username',
        finalMessage: 'hello',
        dateTime: '12h30p'),
    PersonChatted(
        avatar: "",
        username: 'username',
        finalMessage: 'hello',
        dateTime: '12h30p'),
    PersonChatted(
        avatar: "",
        username: 'username',
        finalMessage: 'hello',
        dateTime: '12h30p')
  ];

  _newChat() {
    print('new chat');
  }

  @override
  void initState() {
    super.initState();
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
            SizedBox(
              height: 18,
            ),
            nearUserChated(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child:
                  Divider(color: colorScheme(context).scrim.withOpacity(0.1)),
            ),
            chatContent(persons)
          ],
        ),
      ),
    );
  }
}

Widget chatContent(List<PersonChatted> persons) {
  return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        PersonChatted person = persons[index];
        return ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(),
                ));
          },
          trailing: Text(
            person.dateTime,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: colorScheme(context).scrim.withOpacity(0.6)),
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
            person.finalMessage,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: colorScheme(context).scrim.withOpacity(0.6)),
          ),
        );
      },
      separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(color: colorScheme(context).scrim.withOpacity(0.1)),
          ),
      itemCount: persons.length);
}

Widget nearUserChated() {
  return Container(
    height: 120,
    child: ListView.separated(
      itemCount: 12,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Row(
        children: [
          SizedBox(
            width: 18,
          ),
          avatarMessage(context),
        ],
      ),
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: 18,
        );
      },
    ),
  );
}
