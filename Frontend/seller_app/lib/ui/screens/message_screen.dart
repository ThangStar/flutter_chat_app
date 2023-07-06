import 'package:flutter/material.dart';
import 'package:seller_app/ui/screens/chat_screen.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';

import '../widgets/avatar_message.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<MessageScreen> {
  _newChat() {
    print('new chat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(backgroundColor: colorScheme(context).secondary ,onPressed: (){}, child: Icon(
        color: colorScheme(context).onPrimary,
          Icons.add),),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Chào Alex,",
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyLarge,
            ),
            Text("Tin nhắn",
                style: Theme
                    .of(context)
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
              child: Divider(
                  color: colorScheme(context).scrim.withOpacity(0.1)),
            ),
            chatContent()
          ],
        ),
      ),
    );
  }
}

Widget chatContent() {
  return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) =>
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(),));
            },
            trailing: Text("1 phút trước", style: Theme
                .of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(
                color: colorScheme(context).scrim.withOpacity(0.6)
            ),),
            leading: Image.asset(
              width: 62,
              height: 62,
              'assets/images/avatar.png',
            ),
            title: Text(
              "KOKO",
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            subtitle: Text(
              "sub title",
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(
                  color: colorScheme(context).scrim.withOpacity(0.6)),
            ),
          ),
      separatorBuilder: (context, index) =>
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(color: colorScheme(context).scrim.withOpacity(0.1)),
          ),
      itemCount: 5);
}

Widget nearUserChated() {
  return Container(
    height: 120,
    child: ListView.separated(
      itemCount: 12,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) =>
          Row(
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
