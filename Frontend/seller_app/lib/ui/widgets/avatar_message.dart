import 'package:flutter/material.dart';
import 'package:seller_app/ui/widgets/avatar.dart';

import '../../constants/constants.dart';

Widget avatarMessage(String fullname, String avatarUrl, BuildContext context) {
  return Column(
    children: [
      Avatar(url: avatarUrl),
      SizedBox(
        height: 5,
      ),
      Text(
        fullname,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 15,
          fontWeight: FontWeight.bold
            ),
      )
    ],
  );
}
