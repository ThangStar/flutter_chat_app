import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app/model/post.dart';
import 'package:seller_app/model/profile.dart';
import 'package:seller_app/ui/screens/add_post_screen.dart';
import 'package:seller_app/ui/widgets/avatar_and_action_button.dart';
import 'package:seller_app/ui/widgets/my_divider.dart';
import 'package:seller_app/ui/widgets/post_item.dart';
import 'package:seller_app/storages/storage.dart';

import '../blocs/post/post_bloc.dart';
import '../widgets/shimmer_loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  // IO.Socket _socket = SocketInstance().socket;
  // _connectSocket() {
  //   _socket.onConnect((data) => print('Connection established'));
  //   _socket.onConnectError((data) => print('Connect Error: $data'));
  //   _socket.onDisconnect((data) => print('Socket.IO server disconnected'));
  // }
  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(InitPostEvent());
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: AvatarAndActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPostScreen(),
                      ));
                },
              ),
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
                        const CircularProgressIndicator(),
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
                        const MyDivider(isPrimary: false),
                    itemCount: state.posts.length);
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
