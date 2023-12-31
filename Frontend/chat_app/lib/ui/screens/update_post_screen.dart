import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_app/model/post.dart';
import 'package:seller_app/storages/storage.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';
import 'package:seller_app/ui/widgets/avatar.dart';
import 'package:seller_app/ui/widgets/my_button.dart';
import 'package:seller_app/utils/image_picker.dart';

import '../../model/profile.dart';
import '../blocs/post/post_bloc.dart';

class BoxMedia {
  final IconData icon;
  final String label;
  final String subLabel;
  final Color primaryColor;

  BoxMedia(
      {required this.icon,
      required this.label,
      required this.subLabel,
      required this.primaryColor});
}

class UpdatePostScreen extends StatefulWidget {
  const UpdatePostScreen({super.key, required this.post, required this.onChangeImage});
  final Post post;
  final Function(String) onChangeImage;

  @override
  State<UpdatePostScreen> createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  List<Color> colors = [
    Colors.grey.withOpacity(0.1),
    const Color(0xFF6E85E3),
    const Color(0xFF049C6B),
    const Color(0xFFF62F63),
    const Color(0xFF7D5260),
    const Color(0xFF966FDB),
    const Color(0xFF5B5296),
  ];

  List<Color> bigContainerColors = [
    const Color(0xFF049C6B).withOpacity(0.1),
    const Color(0xFF7D5260).withOpacity(0.1),
    const Color(0xFFF62F63).withOpacity(0.1),
    const Color(0xFF966FDB).withOpacity(0.1),
    const Color(0xFF5B5296).withOpacity(0.1),
  ];
  Color currentColorBg = Colors.grey.withOpacity(0.1);
  bool isChangeColor = false;

  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerContent = TextEditingController();
  Profile profile = Profile(
      id: 1,
      username: "username",
      fullName: "fullName",
      password: "password",
      avatar: "avatar");
  bool isPostting = false;
  final ScrollController _scrollMain = ScrollController();

  List<XFile> imageSelected = [];
  List<BoxMedia> boxMedias = [
    BoxMedia(
        icon: Icons.image,
        label: "Thư viện ảnh",
        subLabel: "Hình ảnh",
        primaryColor: Colors.red),
    BoxMedia(
        icon: Icons.video_collection_sharp,
        label: "Đa phương tiện",
        subLabel: "Video",
        primaryColor: Colors.green),
  ];

  double valueProgress = 0;

  @override
  void initState() {
    super.initState();
    controllerTitle.text = widget.post.title;
    controllerContent.text = widget.post.content;
    try {
      Storage.getMyProfile().then((value) {
        if (value != null) {
          setState(() {
            profile = Profile.fromRawJson(value);
          });
        }
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(
          isPostting ? "Đang sửa.." : "Sửa bài đăng",
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocListener<PostBloc, PostState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case SuccessUpdatePostState:
              {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Đã cập nhật"),
                  backgroundColor: Colors.green,
                ));
                Navigator.pop(context);
              }
              break;
            case FailureUpdatePostState:
              {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Đã xảy ra lỗi"),
                  backgroundColor: Colors.red,
                ));
              }
          }
        },
        child: SingleChildScrollView(
          controller: _scrollMain,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocListener<PostBloc, PostState>(
                listener: (context, state) {
                  if (state is AddPostting) {
                    _scrollMain.animateTo(_scrollMain.position.minScrollExtent,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.bounceOut);
                    setState(() {
                      isPostting = true;
                    });
                  } else if (state is AddPostSucces) {
                    context.read<PostBloc>().add(InitPostEvent());
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Đã cập nhật!"),
                      backgroundColor: Colors.green,
                    ));
                    Navigator.pop(context);
                    setState(() {
                      isPostting = false;
                    });
                  } else if (state is AddPostFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Đã xảy ra lỗi!"),
                        backgroundColor: Colors.red));
                    setState(() {
                      isPostting = false;
                    });
                  }
                },
                child: isPostting
                    ? LinearProgressIndicator(
                        value: valueProgress, //1 is max 100%
                      )
                    : Container(),
              ),
              const SizedBox(
                height: 21,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Avatar(url: profile.avatar),
                    const SizedBox(
                      width: 17,
                    ),
                    Text(profile.fullName)
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AnimatedContainer(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: currentColorBg,
                  ),
                  duration: const Duration(milliseconds: 200),
                  child: TextField(
                    controller: controllerTitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isChangeColor
                            ? colorScheme(context).scrim
                            : Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Tiêu đề",
                        hintStyle: TextStyle(
                            color: isChangeColor
                                ? Colors.white
                                : colorScheme(context).scrim),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 21, vertical: 18)),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AnimatedContainer(
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    color: currentColorBg,
                  ),
                  duration: const Duration(milliseconds: 200),
                  child: TextField(
                    controller: controllerContent,
                    maxLines: null,
                    expands: true,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isChangeColor
                            ? colorScheme(context).scrim
                            : Colors.white),
                    decoration: InputDecoration(
                        hintText: "Nội dung",
                        hintStyle: TextStyle(
                            color: isChangeColor
                                ? Colors.white
                                : colorScheme(context).scrim),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 21, vertical: 18)),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              imageSelected.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.all(16),
                      height: 120,
                      child: ListView.separated(
                        itemCount: imageSelected.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          XFile image = imageSelected[index];
                          return Container(
                              decoration:
                                  BoxDecoration(border: Border.all(width: 1)),
                              child: Image.file(
                                  fit: BoxFit.cover, File(image.path)));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 6,
                          );
                        },
                      ),
                    )
                  : const SizedBox.shrink(),
              Container(
                margin: const EdgeInsets.only(left: 16),
                height: 45,
                child: ListView.separated(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Color color = colors[index];
                    return BoxItemPost(
                      color: color,
                      width: 65,
                      height: 45,
                      radius: 6,
                      onPressed: () {
                        setState(() {
                          if (index != 0) {
                            !isChangeColor ? isChangeColor = true : null;
                          } else {
                            isChangeColor = false;
                          }
                          currentColorBg = color;
                        });
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 16,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                margin: const EdgeInsets.only(left: 16),
                height: 160,
                child: ListView.separated(
                  itemCount: boxMedias.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    BoxMedia boxMedia = boxMedias[index];
                    return ItemMediaPost(
                      onTap: () async {
                        List<XFile>? images = await pickerMultiImage();
                        if (images != null) {
                          setState(() {
                            imageSelected = images;
                          });
                        }
                      },
                      icon: boxMedia.icon,
                      label: boxMedia.label,
                      subLabel: boxMedia.subLabel,
                      primaryColor: boxMedia.primaryColor,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 16,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: MyButton(
                  isDisable: isPostting,
                  text: isPostting ? "ĐANG SỬA.." : "SỬA",
                  onPressed: () {
                    widget.onChangeImage(imageSelected.map((e) => e.path).toList().join(","));
                    context.read<PostBloc>().add(UpdatePostEvent(
                        onChangeProgress: (double value) {
                          print("uploading ${value * 100}%");
                          setState(() {
                            valueProgress = value;
                          });
                        },

                        // post: Post(
                        //     idPost: widget.post.idPost,
                        //     images: imageSelected.join(","),
                        //     styleColor: currentColorBg.value.toString(),
                        //     fullName: "fullName",
                        //     title: controllerTitle.text,
                        //     content: controllerContent.text,
                        //     dateTime: "dateTime",
                        //     username: "")

                        post: widget.post.copyWith(
                            images: imageSelected
                                .map((e) => e.path)
                                .toList()
                                .join(","),
                            styleColor: currentColorBg.value.toString(),
                            title: controllerTitle.text,
                            content: controllerContent.text)));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BoxItemPost extends StatelessWidget {
  const BoxItemPost(
      {required this.color,
      super.key,
      required this.width,
      required this.height,
      required this.radius,
      this.onPressed});

  final Color color;
  final double width;
  final double height;
  final double radius;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(radius),
      color: color,
      child: InkWell(
        radius: radius,
        onTap: onPressed,
        child: SizedBox(
          width: width,
          height: height,
        ),
      ),
    );
  }
}

class ItemMediaPost extends StatelessWidget {
  const ItemMediaPost(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.label,
      required this.subLabel,
      required this.primaryColor});

  final Function() onTap;
  final IconData icon;
  final String label;
  final String subLabel;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(10),
        color: primaryColor.withOpacity(0.1),
        child: InkWell(
          radius: 10,
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(21),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Icon(
                    icon,
                    color: primaryColor,
                  ),
                ),
                Text(
                  subLabel,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: primaryColor.withOpacity(0.6)),
                ),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: primaryColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ));
  }
}
