import 'package:flutter/material.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';

class AvatarAndActionButton extends StatelessWidget {
  const AvatarAndActionButton({super.key, required this.onPressed});
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Material(
        borderRadius: BorderRadius.circular(100),
        color: colorScheme(context).tertiary.withOpacity(0.2),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/avatar.png")),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 14),
                child: Text(
                  "Tạo bài đăng?", style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                    color: colorScheme(context).scrim.withOpacity(0.6)
                ),),
              )
            ],
          ),
        ),
      ),
      ),
    );
  }
}
