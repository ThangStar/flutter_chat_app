import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:seller_app/constants/constants.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';
import 'package:seller_app/ui/widgets/avatar.dart';
import 'package:seller_app/utils/spacing_date_to_now.dart';

import '../../model/post.dart';

class PostItem extends StatefulWidget {
  const PostItem(
      {super.key,
      required this.post,
      this.tymEvent,
      this.unTymEvent,
      this.commentCallback});

  final Post post;
  final Function()? tymEvent;
  final Function()? unTymEvent;
  final Function()? commentCallback;

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> with TickerProviderStateMixin {
  late final AnimationController _controllerFavorite;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.post.isLiked ?? false;
    _controllerFavorite =
        AnimationController(vsync: this, value: isFavorite ? 1 : 0);
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
                  Avatar(url: widget.post.avatar ?? ""),
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
                    ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Wrap(spacing: 24, children: [
                    Row(
                      children: [
                        Material(
                          child: InkWell(
                            radius: 100,
                            onTap: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                              if (isFavorite) {
                                widget.tymEvent!();
                                _controllerFavorite.animateTo(1,
                                    duration: const Duration(seconds: 2),
                                    curve: Curves.fastOutSlowIn);
                              } else {
                                widget.unTymEvent!();
                                _controllerFavorite.animateTo(0.3,
                                    duration:
                                        const Duration(milliseconds: 200));
                              }
                            },
                            child: Lottie.asset(
                              options: LottieOptions(
                                enableApplyingOpacityToLayers: true,
                              ),
                              'assets/raw/heart_effect.json',
                              controller: _controllerFavorite,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          widget.post.totalTym.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme(context)
                                      .scrim
                                      .withOpacity(0.8)),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: widget.commentCallback,
                          icon: SvgPicture.asset("assets/svg/comment.svg",
                              width: 18,
                              height: 18,
                              color:
                                  colorScheme(context).scrim.withOpacity(0.7)),
                        ),
                        Text(
                          widget.post.totalComment.toString() ?? "0",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme(context)
                                      .scrim
                                      .withOpacity(0.8)),
                        )
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset("assets/svg/share.svg",
                            width: 18,
                            height: 18,
                            color:
                                colorScheme(context).scrim.withOpacity(0.7))),
                  ]),
                  const SizedBox(
                    width: 90,
                    height: 43,
                    child: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.antiAlias,
                      children: [
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: Avatar(
                                url: 'avatar-1689384802173-863137306.png'),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 20,
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: Avatar(
                                url: 'avatar-1689384802173-863137306.png'),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 40,
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: Avatar(
                                url: 'avatar-1689384802173-863137306.png'),
                          ),
                        ),
                        // Container(
                        //   width: 30,
                        //   height: 30,
                        //   child: const Avatar(
                        //       url: 'avatar-1689384802173-863137306.png'),
                        // ),
                        // Container(
                        //   width: 30,
                        //   height: 30,
                        //   child: const Avatar(
                        //       url: 'avatar-1689384802173-863137306.png'),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
