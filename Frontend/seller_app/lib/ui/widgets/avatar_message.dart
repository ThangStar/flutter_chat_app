import 'package:flutter/material.dart';

import '../../constants/constants.dart';

Widget avatarMessage(String fullname, String avatarUrl, BuildContext context) {
  return Column(
    children: [
      CircleAvatar(backgroundImage: NetworkImage(avatarUrl)),
      SizedBox(
        height: 5,
      ),
      Text(
        fullname,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 15,
            ),
      )
    ],
  );
}
