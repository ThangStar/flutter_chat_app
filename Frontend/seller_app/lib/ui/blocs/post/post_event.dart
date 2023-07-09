part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddPost extends PostEvent{

  final String title;
  final String content;
  final String idUser;

  AddPost({required this.title, required this.content, required this.idUser});
}
