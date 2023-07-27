part of 'comment_bloc.dart';

class CommentState extends Equatable {
  const CommentState({required this.comments});

  final List<Comment> comments;

  @override
  List<Object> get props => [];
}

class FetchingCommentState extends CommentState {
  const FetchingCommentState({required super.comments});
}

class FinishFetchCommentState extends CommentState {
  const FinishFetchCommentState({required super.comments});
}

class ProgressAddComment extends CommentState {
  const ProgressAddComment({required super.comments});
}

class FinishAddComment extends CommentState {
  const FinishAddComment({required super.comments});
}
