import 'package:flutter/material.dart';

import '../theme/color_schemes.dart';

class MyActionButton extends StatelessWidget {
  const MyActionButton(
      {super.key, required this.onPressed, required this.icon});
  final Function() onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: ClipOval(
        child: Material(
            color: colorScheme(context).tertiary.withOpacity(0.3),
            child: InkWell(
                splashColor: Colors.green,
                onTap: onPressed,
                child:
                    Container(padding: const EdgeInsets.all(12), child: icon))),
      ),
    );
  }
}
