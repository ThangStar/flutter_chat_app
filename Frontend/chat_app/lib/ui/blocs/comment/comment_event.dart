part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HandleFetchDataCommentEvent extends CommentEvent {
  final int idPost;

  const HandleFetchDataCommentEvent({required this.idPost});
}

class HandleAddCommentEvent extends CommentEvent {
  final String content;
  final int idPost;

  const HandleAddCommentEvent({required this.content, required this.idPost});
}
