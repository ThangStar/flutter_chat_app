import 'package:flutter/material.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key, required this.onPressed, this.text, this.isDisable = false});

  final Function() onPressed;
  final String? text;
  final bool isDisable;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: isDisable
          ? colorScheme(context).secondary.withOpacity(0.3)
          : colorScheme(context).secondary,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: !isDisable ? onPressed : null,
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Center(
                child: Text(
              text ?? "Button",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: colorScheme(context).onPrimary),
            ))),
      ),
    );
  }
}
