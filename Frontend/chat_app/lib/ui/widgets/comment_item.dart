import 'package:flutter/material.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';
import 'package:seller_app/ui/widgets/avatar.dart';
import 'package:seller_app/utils/spacing_date_to_now.dart';

import '../../model/comment.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;

  const CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 1, child: Avatar(url: comment.avatar)),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 15),
                    decoration: BoxDecoration(
                        color: comment.myComment
                            ? colorScheme(context).tertiary.withOpacity(0.3)
                            : colorScheme(context).tertiary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comment.username,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              comment.content,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: colorScheme(context)
                                          .scrim
                                          .withOpacity(0.6)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Thích",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: colorScheme(context).primary,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text("Phản hồi",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: colorScheme(context).primary,
                                    fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(spacingDateToNow(comment.dateTime),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: colorScheme(context)
                                      .scrim
                                      .withOpacity(0.6))),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz_outlined)))
          ],
        ),
      ],
    );
  }
}
