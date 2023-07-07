import 'package:flutter/material.dart';

Widget avatarMessage(String fullname, BuildContext context) {
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
        fullname,
        style: Theme.of(context).textTheme.bodyLarge,
      )
    ],
  );
}
