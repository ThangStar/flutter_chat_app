import 'package:flutter/material.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';

class MessageChat extends StatefulWidget {
  const MessageChat(
      {super.key,
      required this.message,
      required this.dateTime,
      required this.isMyMessage});

  final String message;
  final String dateTime;
  final bool isMyMessage;

  @override
  State<MessageChat> createState() => _MessageChatState();
}

class _MessageChatState extends State<MessageChat> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isMyMessage ? Alignment.topRight : Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
              color: colorScheme(context).secondary,
              borderRadius: BorderRadius.circular(100),
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 19, vertical: 8),
                  child: Text(
                    widget.message,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: colorScheme(context).onSecondary),
                  ),
                ),
              )),
          SizedBox(
            height: 6,
          ),
          AnimatedSize(
              duration: const Duration(milliseconds: 200),
              child: isExpanded
                  ? Text(
                      widget.message,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  : const SizedBox())
        ],
      ),
    );
  }
}
