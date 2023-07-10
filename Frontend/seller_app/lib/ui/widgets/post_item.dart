import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';
import 'package:seller_app/utils/spacing_date_to_now.dart';

import '../../model/post.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                      backgroundImage: AssetImage("assets/images/avatar.png")),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        post.username,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        post.dateTime == ""
                            ? ""
                            : spacingDateToNow(DateTime.parse(post.dateTime)),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w100,
                            color: colorScheme(context).scrim.withOpacity(0.6)),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.more_horiz_outlined))
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                post.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                post.content,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 15,
                    color: colorScheme(context).scrim.withOpacity(0.6)),
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Wrap(spacing: 24, children: [
                    IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset("assets/svg/heart.svg")),
                    IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset("assets/svg/comment.svg")),
                    IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset("assets/svg/share.svg")),
                  ]),
                ],
              ),
            ],
          )),
    );
  }
}
