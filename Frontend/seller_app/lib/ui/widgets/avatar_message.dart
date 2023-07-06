import 'package:flutter/material.dart';

Widget avatarMessage(BuildContext context) {
  return Column(
    children: [
      Image.asset(
        width: 62,
        height: 62,
        'assets/images/avatar.png',
      ),
      SizedBox(
        height: 5,
      ),
      Text(
        "John",
        style: Theme.of(context).textTheme.bodyLarge,
      )
    ],
  );
}
