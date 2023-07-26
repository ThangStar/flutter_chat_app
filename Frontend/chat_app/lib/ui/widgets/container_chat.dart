import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';
import 'package:seller_app/utils/image_picker.dart';

class ContainerChat extends StatefulWidget {
  const ContainerChat(
      {super.key, required this.handleActionSend, required this.onTapImage});

  final Function(String) handleActionSend;
  final Function() onTapImage;

  @override
  State<ContainerChat> createState() => _ContainerChatState();
}

class _ContainerChatState extends State<ContainerChat> {
  TextEditingController messageController = TextEditingController();
  bool isEditting = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme(context).tertiary.withOpacity(0.1),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: widget.onTapImage,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: Colors.pink[600]!),
                color: Colors.pink[50],
              ),
              child: Icon(
                Icons.image,
                color: Colors.pink[600],
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorScheme(context).onSecondary,
                  border: Border.all(
                    width: 1,
                    color: isEditting
                        ? colorScheme(context).secondary
                        : colorScheme(context).tertiary,
                  )),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Nhập tin nhắn..",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: colorScheme(context)
                                      .scrim
                                      .withOpacity(0.6)),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 12),
                          prefixIconColor: Colors.amber,
                          isDense: true),
                      controller: messageController,
                      onTapOutside: (event) {
                        setState(() {
                          isEditting = false;
                        });
                      },
                      onTap: () {
                        setState(() {
                          isEditting = true;
                        });
                      },
                    ),
                  ),
                  Material(
                    borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(8)),
                    color: Colors.green[500],
                    child: InkWell(
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(8)),
                      onTap: () {
                        widget.handleActionSend(messageController.text);
                        messageController.text = "";
                      },
                      splashColor: Colors.green[800],
                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
