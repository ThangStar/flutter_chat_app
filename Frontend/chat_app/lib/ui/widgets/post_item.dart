
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';
import 'package:seller_app/utils/spacing_date_to_now.dart';

import '../../model/post.dart';

class PostItem extends StatefulWidget {
  const PostItem({super.key, required this.post});

  final Post post;

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> with TickerProviderStateMixin {
  late final AnimationController _controllerFavorite;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _controllerFavorite = AnimationController(
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controllerFavorite.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                      backgroundImage: AssetImage("assets/images/avatar.png")),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.post.username,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.post.dateTime == ""
                            ? ""
                            : spacingDateToNow(
                                DateTime.parse(widget.post.dateTime)),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w100,
                            color: colorScheme(context).scrim.withOpacity(0.6)),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz_outlined))
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                widget.post.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),
              widget.post.styleColor == null ||
                      widget.post.styleColor == "446602910"
                  ? Text(
                      widget.post.content,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 15,
                          color: colorScheme(context).scrim.withOpacity(0.6)),
                    )
                  : Container(
                      width: double.infinity,
                      height: 220,
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                          color: widget.post.styleColor == null
                              ? const Color(0xFFFFFFFF)
                              : Color(int.parse(widget.post.styleColor!)),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          widget.post.content,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Wrap(spacing: 24, children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                        if (isFavorite) {
                          _controllerFavorite.animateTo(1,
                              duration: const Duration(seconds: 2),
                              curve: Curves.fastOutSlowIn);
                        } else {
                          _controllerFavorite.animateTo(0.3,
                              duration: const Duration(milliseconds: 200));
                        }
                      },
                      icon: Lottie.asset(
                        'assets/raw/heart_effect.json',
                        controller: _controllerFavorite,
                        width: 50,
                        height: 50,
                        fit: BoxFit.fill,
                      ),
                    ),
                    IconButton(
                      padding: const EdgeInsets.all(20),
                      onPressed: () {},
                      icon: SvgPicture.asset("assets/svg/comment.svg",
                          width: 23,
                          height: 23,
                          color: colorScheme(context).scrim.withOpacity(0.7)),
                    ),
                    IconButton(
                        padding: const EdgeInsets.all(20),
                        onPressed: () {},
                        icon: SvgPicture.asset("assets/svg/share.svg",
                            width: 23,
                            height: 23,
                            color:
                                colorScheme(context).scrim.withOpacity(0.7))),
                  ]),
                ],
              ),
            ],
          )),
    );
  }
}
