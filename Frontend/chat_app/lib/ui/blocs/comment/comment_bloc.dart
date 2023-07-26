import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:seller_app/api/api.dart';
import 'package:seller_app/utils/response.dart';

import '../../../model/comment.dart';

part 'comment_event.dart';

part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(const CommentState(comments: [])) {
    on<HandleFetchDataCommentEvent>(_handleFetchDataCommentEvent);
  }

  FutureOr<void> _handleFetchDataCommentEvent(
      HandleFetchDataCommentEvent event, Emitter<CommentState> emit) async {
    try {
      emit(FetchingCommentState(comments: state.comments));
      Object response = await Api.getCommentById(event.idPost);
      if (response is Success) {
        final jsonComments = jsonDecode(response.body) as List<dynamic>;
       final List<Comment> comments =  jsonComments.map((e) => Comment.fromJson(e)).toList();
       emit(CommentState(comments: comments));
      } else if (response is Failure) {
        print('failure');
      }
    } catch (err) {
      print('failure');
    } finally {
      emit(FinishFetchCommentState(comments: state.comments));
    }
  }
}
