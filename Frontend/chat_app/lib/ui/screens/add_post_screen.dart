import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app/storages/storage.dart';
import 'package:seller_app/ui/widgets/avatar.dart';
import 'package:seller_app/ui/widgets/my_button.dart';

import '../../model/profile.dart';
import '../blocs/post/post_bloc.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
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

  @override
  void initState() {
    super.initState();
    try {
      Storage.getMyProfile().then((value) {
        if (value != null) {
          setState(() {
            profile = Profile.fromRawJson(value ?? "");
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
          isPostting ? "Đang đăng" : "Tạo bài đăng",
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
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
                    content: Text("Đã đăng!"),
                    backgroundColor: Colors.green,
                  ));
                  Navigator.pop(context);
                  setState(() {
                    isPostting = false;
                  });
                } else if (state is AddPostFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Đã xảy ra lỗi!"),
                      backgroundColor: Colors.red));
                  setState(() {
                    isPostting = false;
                  });
                }
              },
              child: isPostting ? const LinearProgressIndicator() : Container(),
            ),
            const SizedBox(
              height: 21,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Avatar(
                      url: profile.avatar),
                  const SizedBox(
                    width: 17,
                  ),
                  Text(profile.fullName )
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: currentColorBg,
                ),
                child: TextField(
                  controller: controllerTitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isChangeColor ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Tiêu đề",
                      hintStyle: TextStyle(
                          color: isChangeColor ? Colors.white : Colors.black),
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
              child: Container(
                height: 220,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  color: currentColorBg,
                ),
                child: TextField(
                  controller: controllerContent,
                  maxLines: null,
                  expands: true,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isChangeColor ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                      hintText: "Nội dung",
                      hintStyle: TextStyle(
                          color: isChangeColor ? Colors.white : Colors.black),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 21, vertical: 18)),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
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
              height: 120,
              child: ListView.separated(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Color color = bigContainerColors[index];
                  return BoxItemPost(
                    color: color,
                    width: 150,
                    height: 120,
                    radius: 10,
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
                text: isPostting ? "ĐANG ĐĂNG.." : "ĐĂNG",
                onPressed: () {
                  context.read<PostBloc>().add(AddPost(
                      styleColor: currentColorBg.value.toString(),
                      title: controllerTitle.text,
                      content: controllerContent.text,
                      idUser: profile.id.toString()));
                },
              ),
            )
          ],
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
        onTap: onPressed,
        child: SizedBox(
          width: width,
          height: height,
        ),
      ),
    );
  }
}
