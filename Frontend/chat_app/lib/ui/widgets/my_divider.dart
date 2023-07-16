import 'package:flutter/material.dart';

import '../theme/color_schemes.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key, required this.isPrimary});
  final bool isPrimary;
  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: isPrimary ? 8 : 4,
      color: colorScheme(context).tertiary.withOpacity(0.3),
    );
  }
}
