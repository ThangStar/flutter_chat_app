import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_app/api/api.dart';
import 'package:seller_app/model/post.dart';
import 'package:seller_app/model/profile.dart';
import 'package:seller_app/storages/storage.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';
import 'package:seller_app/ui/widgets/info_item_user.dart';
import 'package:seller_app/ui/widgets/my_divider.dart';

import '../../utils/image_picker.dart';
import '../blocs/post/post_bloc.dart';
import '../widgets/avatar_and_action_button.dart';
import '../widgets/post_item.dart';
import '../widgets/shimmer_loading.dart';
import 'add_post_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String fullname = "";

  @override
  void initState() {
    super.initState();
    Storage.getMyProfile().then((value) {
      Profile profile = Profile.fromRawJson(value ?? "");
      setState(() {
        fullname = profile.username;
      });
    });

    context.read<PostBloc>().add(InitPostEvent());
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme(context).background,
        leading: const BackButton(),
        title: Text(
          fullname,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset('assets/images/wallpaper.jpg',
                    width: double.infinity, fit: BoxFit.cover),
                Positioned(
                  bottom: -10,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () async {
                           XFile? image = await pickerImage();
                           Api.uploadAvatar(image!.path);
                          },
                          child: Image.asset(
                            'assets/images/avatar.png',
                            width: 80,
                            height: 80,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fullname,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: colorScheme(context)
                                          .onPrimary
                                          .withOpacity(0.8),
                                      fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "@$fullname",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: colorScheme(context)
                                          .onPrimary
                                          .withOpacity(0.8),
                                      fontWeight: FontWeight.w100),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: sizeScreen.width / 4,
                  ),
                  SizedBox(
                    width: sizeScreen.width / 2,
                    child: Text(
                      textAlign: TextAlign.center,
                      "Said i fine! said im move on, I’m only here passing time in her arm",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w200,
                          color: colorScheme(context).scrim.withOpacity(0.6)),
                    ),
                  ),
                  Container(
                    width: sizeScreen.width / 4,
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.edit_note)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const InfoItemUser(amount: "20K", title: "Theo dõi"),
                    VerticalDivider(
                      color: colorScheme(context).tertiary.withOpacity(0.3),
                    ),
                    const InfoItemUser(amount: "20K", title: "Theo dõi"),
                    VerticalDivider(
                      color: colorScheme(context).tertiary.withOpacity(0.3),
                    ),
                    const InfoItemUser(amount: "20K", title: "Theo dõi")
                  ],
                ),
              ),
            ),
            MyDivider(isPrimary: true),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Text(
                "Bài đăng",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            AvatarAndActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddPostScreen()));
              },
            ),
            SizedBox(
              height: 16,
            ),
            BlocListener<PostBloc, PostState>(
              listener: (context, state) {
                try {
                  if (state is LoadingPost) {
                    setState(() {
                      isLoading = true;
                    });
                  } else if (state is LoadingPostFinish) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                } catch (err) {}
              },
              child: isLoading
                  ? Column(
                      children: [
                        CircularProgressIndicator(),
                        ShimmerLoading(
                          isLoading: true,
                          child: Column(
                            children: [
                              PostItem(
                                post: Post(
                                    title: "",
                                    content: "",
                                    dateTime: '',
                                    username: ''),
                              ),
                              PostItem(
                                post: Post(
                                    title: "",
                                    content: "",
                                    dateTime: '',
                                    username: ''),
                              ),
                              PostItem(
                                post: Post(
                                    title: "",
                                    content: "",
                                    dateTime: '',
                                    username: ''),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : MyDivider(isPrimary: false),
            ),
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                return ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      Post post = state.posts[index];
                      return PostItem(post: post);
                    },
                    separatorBuilder: (context, index) =>
                        MyDivider(isPrimary: false),
                    itemCount: state.posts.length);
              },
            )
          ],
        ),
      ),
    );
  }
}
