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
  ScrollController controllerComments = ScrollController();
  bool isCommentting = false;

  @override
  void initState() {
    super.initState();
    context
        .read<CommentBloc>()
        .add(HandleFetchDataCommentEvent(idPost: widget.post.idPost ?? 0));
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: ContainerChat(
            onTapImage: () {},
            handleActionSend: (txtMessage) {
              controllerComments.animateTo(
                  controllerComments.position.minScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.bounceOut);
              context.read<CommentBloc>().add(HandleAddCommentEvent(
                  content: txtMessage, idPost: widget.post.idPost ?? 0));
            }),
        appBar: AppBar(
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(10),
                child: BlocListener<CommentBloc, CommentState>(
                  listener: (context, state) {
                    if (state is ProgressAddComment) {
                      setState(() {
                        isCommentting = true;
                      });
                    } else if (state is FinishAddComment) {
                      setState(() {
                        isCommentting = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Đã bình luận"),
                          backgroundColor: Colors.green));
                    }
                  },
                  child:
                      isCommentting ? const LinearProgressIndicator() : Container(),
                )),
            leading: const BackButton(),
            title: Text(
              isCommentting ? "Đang bình luận.." : "Bình luận",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            )),
        body: SingleChildScrollView(
          controller: controllerComments,
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
              const SizedBox(
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
                        const SizedBox(
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
