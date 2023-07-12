import 'package:flutter/material.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';

import '../../constants/constants.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key, required this.url, this.isLarge = false});

  final String url;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    return !isLarge
        ? CircleAvatar(
            backgroundColor: colorScheme(context).tertiary,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage("${Constants.BASE_URL}/images/$url"),
              ),
            ),
          )
        : Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: colorScheme(context).tertiary ),
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage("${Constants.BASE_URL}/images/$url"),
                  fit: BoxFit.cover),
            ),
          );
  }
}
