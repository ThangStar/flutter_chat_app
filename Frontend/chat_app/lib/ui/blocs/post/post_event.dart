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
  final List<XFile>? imageSelected;
  final Function(double value) onChangeProgress;

  const AddPost(
      {required this.onChangeProgress,
      required this.imageSelected,
      required this.title,
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

class DeletePostEvent extends PostEvent {
  final int idPost;

  const DeletePostEvent({required this.idPost});
}

class HidePostEvent extends PostEvent {
  final int idPost;

  const HidePostEvent({required this.idPost});
}

class UpdatePostEvent extends PostEvent {
  final Post post;
  final Function(double value) onChangeProgress;
  const UpdatePostEvent({required this.onChangeProgress, required this.post});
}
