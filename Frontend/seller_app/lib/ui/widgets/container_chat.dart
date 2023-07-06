import 'package:flutter/material.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';

class ContainerChat extends StatelessWidget {
  const ContainerChat({super.key, required this.handleActionSend});

  final Function(String) handleActionSend;

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme(context).tertiary.withOpacity(0.1),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(11),
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
          SizedBox(
            width: 20,
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorScheme(context).onSecondary,
                  border: Border.all(
                    width: 1,
                    color: colorScheme(context).tertiary,
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
                              ?.copyWith(color: Colors.black.withOpacity(0.6)),
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          prefixIconColor: Colors.amber,
                          isDense: true),
                      controller: messageController,
                    ),
                  ),
                  Material(
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(8)),
                    color: Colors.green[500],
                    child: InkWell(
                      borderRadius:
                          BorderRadius.horizontal(right: Radius.circular(8)),
                      onTap: ()=>handleActionSend(messageController.text),
                      splashColor: Colors.green[800],
                      child: SizedBox(
                        width: 56,
                        height: 60,
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
