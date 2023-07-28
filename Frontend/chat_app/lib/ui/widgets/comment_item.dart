import 'package:flutter/material.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';
import 'package:seller_app/ui/utils/role.dart';
import 'package:seller_app/ui/widgets/avatar.dart';
import 'package:seller_app/utils/spacing_date_to_now.dart';

import '../../model/comment.dart';
import '../../storages/storage.dart';

class CommentItem extends StatefulWidget {
  final Comment comment;

  const CommentItem({super.key, required this.comment});

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  @override
  void initState()  {
    print(widget.comment.myComment);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 1, child: Avatar(url: widget.comment.avatar)),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 15),
                    decoration: BoxDecoration(
                        color: widget.comment.myComment
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
                              widget.comment.fullName,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              widget.comment.content,
                              style: Theme
                                  .of(context)
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
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Thích",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                              color: colorScheme(context).primary,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text("Phản hồi",
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                color: colorScheme(context).primary,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(spacingDateToNow(widget.comment.dateTime),
                          style: Theme
                              .of(context)
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
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: PopupMenuButton(
                  onSelected: (value) {
                    print("value selected: ${value}");
                  },
                  itemBuilder: (context) {
                    return widget.comment.myComment ? Role.myComment.map((e) => PopupMenuItem(
                        value: e["value"],
                        child: Text(e["content"] ?? ""),
                      )).toList()
                        :
                    Role.otherComment.map((e) => PopupMenuItem(
                      value: e["value"],
                      child: Text(e["content"] ?? ""),
                    )).toList();

                  },
                ))
          ],
        ),
      ],
    );
  }
}

