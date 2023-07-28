import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:seller_app/api/api.dart';
import 'package:seller_app/storages/storage.dart';
import 'package:seller_app/utils/response.dart';

import '../../../model/comment.dart';
import '../../../model/profile.dart';

part 'comment_event.dart';

part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(const CommentState(comments: [])) {
    on<HandleFetchDataCommentEvent>(_handleFetchDataCommentEvent);
    on<HandleAddCommentEvent>(_handleAddCommentEvent);
    on<HandleDeleteOneCommentEvent>(_handleDeleteOneCommentEvent);
  }

  FutureOr<void> _handleFetchDataCommentEvent(
      HandleFetchDataCommentEvent event, Emitter<CommentState> emit) async {
    try {
      emit(FetchingCommentState(comments: state.comments));
      Object response = await Api.getCommentById(event.idPost);
      if (response is Success) {
        final jsonComments = jsonDecode(response.body) as List<dynamic>;
        final List<Comment> comments =
            jsonComments.map((e) => Comment.fromJson(e)).toList();
        emit(CommentState(comments: comments));
      } else if (response is Failure) {
        print('failure');
      }
    } catch (err) {
      print('failure $err');
    } finally {
      emit(FinishFetchCommentState(comments: state.comments));
    }
  }

  FutureOr<void> _handleAddCommentEvent(
      HandleAddCommentEvent event, Emitter<CommentState> emit) async {
    try {
      emit(ProgressAddComment(comments: state.comments));
      await Future.delayed(Duration(seconds: 2));
      String? jsonProfile = await Storage.getMyProfile();

      Profile profile = Profile.fromRawJson(jsonProfile ?? "null");

      Object response =
          await Api.addComment(profile.id, event.idPost, event.content);
      if (response is Success) {
        final jsonComments = jsonDecode(response.body) as List<dynamic>;
        final List<Comment> comments =
            jsonComments.map((e) => Comment.fromJson(e)).toList();
        emit(CommentState(comments: comments));
      } else if (response is Failure) {
        print("${response.message}");
        print(
          'failure',
        );
      }
    } catch (err) {
      print('failure error $err');
    } finally {
      emit(FinishAddComment(comments: state.comments));
    }
  }

  FutureOr<void> _handleDeleteOneCommentEvent(
      HandleDeleteOneCommentEvent event, Emitter<CommentState> emit) async {
    try {
      emit(ProgressDeleteOneComment(comments: state.comments));

      await Future.delayed(Duration(seconds: 2));
      Object response =
          await Api.deleteOneComment(event.idPost, event.idComment);
      if (response is Success) {
        final jsonComments = jsonDecode(response.body) as List<dynamic>;
        final List<Comment> comments =
            jsonComments.map((e) => Comment.fromJson(e)).toList();
        emit(CommentState(comments: comments));
      } else if (response is Failure) {
        print("failure ${response.message}");
      }
    } catch (err) {
    } finally {
      emit(FinishDeleteOneComment(comments: state.comments));
    }
  }
}
