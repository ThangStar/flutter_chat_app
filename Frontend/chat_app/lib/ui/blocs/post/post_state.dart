part of 'post_bloc.dart';

class PostState extends Equatable {
  final List<Post> posts;
  const PostState({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class AddPostting extends PostState {
  const AddPostting({required super.posts});
}

class AddPostSucces extends PostState {
  const AddPostSucces({required super.posts});
}

class AddPostFailure extends PostState {
  const AddPostFailure({required super.posts});
}

class LoadingPost extends PostState {
  LoadingPost({required super.posts});
}

class LoadingPostFinish extends PostState {
  LoadingPostFinish({required super.posts});
}

class TymFinish extends PostState {
  TymFinish({required super.posts});
}

class ProgressDeletePostState extends PostState {
  const ProgressDeletePostState({required super.posts});
}

class FailureDeletePostState extends PostState{
  const FailureDeletePostState({required super.posts});
}

class SuccessDeletePostState extends PostState{
  const SuccessDeletePostState({required super.posts});

}

class FinishDeletePostState extends PostState {
  const FinishDeletePostState({required super.posts});
}
