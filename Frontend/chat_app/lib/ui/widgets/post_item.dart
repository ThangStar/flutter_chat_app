import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:seller_app/ui/blocs/post/post_bloc.dart';
import 'package:seller_app/ui/screens/detail_post.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';
import 'package:seller_app/ui/utils/role.dart';
import 'package:seller_app/ui/widgets/avatar.dart';
import 'package:seller_app/utils/spacing_date_to_now.dart';

import '../../constants/constants.dart';
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
  bool isDeletting = false;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Avatar(url: widget.post.avatar ?? ""),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.post.fullName,
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
                PopupMenuButton(
                  onSelected: (value) {
                    switch (value) {
                      case "edit":
                        break;
                      case "hide":
                        print(value);
                        break;
                      case "delete":
                        context.read<PostBloc>().add(
                            DeletePostEvent(idPost: widget.post.idPost!));
                        break;
                    }
                  },
                  icon: const Icon(Icons.more_horiz_outlined),
                  itemBuilder: (BuildContext context) {
                    return Role.post
                        .map((e) => PopupMenuItem(
                              value: e['value'],
                              child: Text(e['label']),
                            ))
                        .toList();
                  },
                )
              ],
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              widget.post.title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          widget.post.styleColor == null ||
                  widget.post.styleColor == "446602910"
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    widget.post.content,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 15,
                        color: colorScheme(context).scrim.withOpacity(0.6)),
                  ),
                )
              : Container(
                  width: double.infinity,
                  height: 220,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                      color: widget.post.styleColor == null
                          ? const Color(0xFFFFFFFF)
                          : Color(int.parse(widget.post.styleColor!))),
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
          widget.post.images != "" && widget.post.images != null
              ? GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: widget.post.images!.split(",").length > 4
                      ? 4
                      : widget.post.images!.split(",").length,
                  itemBuilder: (BuildContext context, int index) {
                    String url = widget.post.images!.split(",")[index];
                    return Stack(
                        fit: StackFit.expand,
                        alignment: Alignment.center,
                        children: [
                          Expanded(
                              child: ColorFiltered(
                            colorFilter: index == 3
                                ? const ColorFilter.mode(
                                    Colors.black, BlendMode.saturation)
                                : const ColorFilter.mode(
                                    Colors.transparent, BlendMode.saturation),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPost(
                                            urlImage: url,
                                            titlePost: widget.post.title,
                                          ))),
                              child: Hero(
                                tag: url,
                                child: Image.network(
                                    fit: BoxFit.cover,
                                    "${Constants.BASE_URL}/images/$url"),
                              ),
                            ),
                          )),
                          widget.post.images!.split(",").length > 4 &&
                                  index == 3
                              ? Positioned(
                                  right: 0,
                                  left: 0,
                                  child: Center(
                                    child: Text(
                                      "+${widget.post.images!.split(",").length - 4}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                          color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ))
                              : const SizedBox.shrink()
                        ]);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          widget.post.images!.split(",").length == 1 ? 1 : 2),
                )
              : const SizedBox.shrink(),
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
                                duration: const Duration(milliseconds: 200));
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
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme(context).scrim.withOpacity(0.8)),
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
                          color: colorScheme(context).scrim.withOpacity(0.7)),
                    ),
                    Text(
                      widget.post.totalComment.toString() ?? "0",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme(context).scrim.withOpacity(0.8)),
                    )
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset("assets/svg/share.svg",
                        width: 18,
                        height: 18,
                        color: colorScheme(context).scrim.withOpacity(0.7))),
              ]),
              SizedBox(
                width: 90,
                height: 43,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.antiAlias,
                  children: [
                    ListView.builder(
                      itemCount:
                          widget.post.avatarsLiked!.split(',').length > 2
                              ? 3
                              : widget.post.avatarsLiked?.split(',').length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (BuildContext context, int index) {
                        String? urlAvatar =
                            widget.post.avatarsLiked?.split(',')[index];
                        return index == 2
                            ? SizedBox(
                                width: 30,
                                height: 30,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CircleAvatar(
                                    backgroundColor: const Color(0xFFF62F63),
                                    child: Text(
                                      "+${widget.post.avatarsLiked!.split(',').length - 2}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: colorScheme(context)
                                                  .onPrimary),
                                    ),
                                  ),
                                ))
                            : SizedBox(
                                width: 30,
                                height: 30,
                                child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.black,
                                      backgroundImage: NetworkImage(
                                          "${Constants.BASE_URL}/images/$urlAvatar"),
                                    )),
                              );
                      },
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
      ),
    );
  }
}
