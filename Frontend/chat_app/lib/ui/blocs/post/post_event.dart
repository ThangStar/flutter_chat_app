part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddPost extends PostEvent {
  final String title;
  final String content;
  final String idUser;
  final String? styleColor;

  const AddPost(
      {required this.title,
      required this.content,
      required this.idUser,
      this.styleColor});
}

class InitPostEvent extends PostEvent {}

class TymPostEvent extends PostEvent {
  final int postId;
  final int index;

  const TymPostEvent({required this.index, required this.postId});
}

class UnTymPostEvent extends PostEvent {
  final int postId;
  final int index;

  const UnTymPostEvent({required this.index, required this.postId});
}
