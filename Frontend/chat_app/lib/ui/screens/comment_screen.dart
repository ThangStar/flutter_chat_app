import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app/model/post.dart';
import 'package:seller_app/ui/widgets/my_divider.dart';
import 'package:seller_app/ui/widgets/post_item.dart';

import '../../model/comment.dart';
import '../blocs/comment/comment_bloc.dart';
import '../widgets/comment_item.dart';
import '../widgets/container_chat.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key, required this.post});

  final Post post;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<CommentBloc>()
        .add(HandleFetchDataCommentEvent(idPost: widget.post.idPost ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: ContainerChat(
            onTapImage: () {},
            handleActionSend: (txtMessage) {
              print(txtMessage);
            }),
        appBar: AppBar(
            leading: const BackButton(),
            title: Text(
              "Bình luận",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            )),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostItem(
                post: widget.post,
              ),
              const MyDivider(isPrimary: false),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "Bình luận",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 16,
              ),
              BlocBuilder<CommentBloc, CommentState>(
                builder: (BuildContext context, state) {
                  return ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: state.comments.length,
                    itemBuilder: (context, index) {
                      Comment comment = state.comments[index];
                      return CommentItem(
                        comment: comment,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                      height: 16,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
