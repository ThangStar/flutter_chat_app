part of 'post_bloc.dart';

 class PostState extends Equatable {
  final List<Post> posts ;
  const PostState({required this.posts});

  @override
  List<Object?> get props => [];
}
class AddPostting extends PostState{
  const AddPostting({required super.posts});
}
class AddPostSucces extends PostState{
  const AddPostSucces({required super.posts});
}

class AddPostFailure extends PostState{
  const AddPostFailure({required super.posts});

}