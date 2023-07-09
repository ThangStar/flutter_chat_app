import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:seller_app/api/api.dart';
import 'package:seller_app/utils/response.dart';

import '../../../model/post.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(const PostState(posts: [])) {
    on<AddPost>(_addPost);
  }

  FutureOr<void> _addPost(AddPost event, Emitter<PostState> emit) async {
    emit(AddPostting(posts: state.posts));
    await Future.delayed(const Duration(seconds: 5));
    try {
      Object res = await Api.addPost(event.title, event.content, event.idUser);
      if (res is Success) {
        emit(AddPostSucces(posts: state.posts));
      } else if (res is Failure) {
        print("failure post: ${res.body}");
        emit(AddPostFailure(posts: state.posts));
      }
    } catch (err) {
      emit(AddPostFailure(posts: state.posts));
    }
  }
}
