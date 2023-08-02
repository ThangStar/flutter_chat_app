import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_app/api/api.dart';
import 'package:seller_app/model/profile.dart';
import 'package:seller_app/storages/storage.dart';
import 'package:seller_app/utils/response.dart';

import '../../../model/post.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(const PostState(posts: [])) {
    on<AddPost>(_addPost);
    on<InitPostEvent>(_initPostEvent);
    on<TymPostEvent>(_tymPostEvent);
    on<UnTymPostEvent>(_unTymPostEvent);
  }

  FutureOr<void> _addPost(AddPost event, Emitter<PostState> emit) async {
    emit(AddPostting(posts: state.posts));
    await Future.delayed(const Duration(seconds: 3));

    try {
      Object res = await Api.addPost(
          event.title, event.content, event.idUser, event.styleColor, event.imageSelected);
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

  FutureOr<void> _initPostEvent(
      InitPostEvent event, Emitter<PostState> emit) async {
    String? jsonPrf = await Storage.getMyProfile();
    Profile prf = Profile.fromRawJson(jsonPrf ?? "");
    emit(LoadingPost(posts: state.posts));
    await Future.delayed(const Duration(seconds: 2));
    try {
      Object res = await Api.getPostByIdUser(prf.id);
      List<Post> posts = [];
      if (res is Success) {
        final postsJson = jsonDecode(res.body) as List<dynamic>;
        for (var e in postsJson) {
          print(e);
          posts.add(Post.fromJson(e ?? ""));
        }
        emit(PostState(posts: posts));
      } else if (res is Failure) {
        print('failure: ${res.statusCode}');
      }
    } catch (err) {
      print("ERROR: $err");
    } finally {
      emit(LoadingPostFinish(posts: state.posts));
    }
  }

  FutureOr<void> _tymPostEvent(
      TymPostEvent event, Emitter<PostState> emit) async {
    String? jsonPrf = await Storage.getMyProfile();
    Profile prf = Profile.fromRawJson(jsonPrf ?? "");
    // print('index- ${event.index} idPost- ${event.postId} myid-${prf.id}');

    Object response = await Api.incTymPost(prf.id, event.postId);

    if (response is Success) {
      List<dynamic> counterJson = jsonDecode(response.body) as List<dynamic>;
      final count = counterJson[0]['count'];
      print(response.body);
      List<Post> posts = state.posts;
      posts[event.index].totalTym = count;
      emit(PostState(posts: posts));
      emit(TymFinish(posts: state.posts));
    } else if (response is Failure) {
      print(response.body);
    }
  }

  FutureOr<void> _unTymPostEvent(
      UnTymPostEvent event, Emitter<PostState> emit) async {
    String? jsonPrf = await Storage.getMyProfile();
    Profile prf = Profile.fromRawJson(jsonPrf ?? "");
    print('index- ${event.index} idPost- ${event.postId} myid-${prf.id}');

    Object response = await Api.decTymPost(prf.id, event.postId);

    if (response is Success) {
      print(response.body);

      List<dynamic> counterJson = jsonDecode(response.body) as List<dynamic>;
      final count = counterJson[0]['count'];

      List<Post> posts = state.posts;
      posts[event.index].totalTym = count;
      emit(PostState(posts: posts));
      emit(TymFinish(posts: state.posts));
    } else if (response is Failure) {
      print(response.body);
    }
  }
}
