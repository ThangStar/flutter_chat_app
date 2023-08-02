import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app/model/post.dart';
import 'package:seller_app/ui/screens/add_post_screen.dart';
import 'package:seller_app/ui/widgets/avatar_and_action_button.dart';
import 'package:seller_app/ui/widgets/my_divider.dart';
import 'package:seller_app/ui/widgets/post_item.dart';

import '../blocs/post/post_bloc.dart';
import '../widgets/shimmer_loading.dart';
import 'comment_screen.dart';

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
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async{ 

         },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                          builder: (context) => const AddPostScreen(),
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
                                      username: '',
                                      fullName: ''),
                                  tymEvent: () {},
                                ),
                                PostItem(
                                  post: Post(
                                      title: "",
                                      content: "",
                                      dateTime: '',
                                      username: '',
                                      fullName: ''),
                                  tymEvent: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : const MyDivider(isPrimary: false),
              ),
              BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  return ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Post post = state.posts[index];
                        return PostItem(
                          commentCallback: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CommentScreen(post: post),
                              )),
                          post: post,
                          tymEvent: () {
                            context.read<PostBloc>().add(TymPostEvent(
                                index: index, postId: post.idPost ?? 0));
                          },
                          unTymEvent: () => context.read<PostBloc>().add(
                              UnTymPostEvent(
                                  index: index, postId: post.idPost ?? 0)),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const MyDivider(isPrimary: false),
                      itemCount: state.posts.length);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
