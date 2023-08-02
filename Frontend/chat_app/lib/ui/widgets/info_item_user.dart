import 'package:flutter/material.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';

class InfoItemUser extends StatelessWidget {
  const InfoItemUser({super.key, required this.amount, required this.title});

  final String amount;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          amount,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold, color: colorScheme(context).scrim),
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: colorScheme(context).scrim.withOpacity(0.6)),
        ),
      ],
    );
  }
}
