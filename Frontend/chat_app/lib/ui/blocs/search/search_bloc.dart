import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../api/api.dart';
import '../../../model/profile.dart';
import '../../../utils/response.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState(profiles: [])) {
    on<HandleSearchEvent>(_handleSearchEvent);
  }

  FutureOr<void> _handleSearchEvent(
      HandleSearchEvent event, Emitter<SearchState> emit) async {
    emit(SearchProgress(profiles: state.profiles));
    try {
      Object result = await Api.searchUserByUsername(event.query);
      if (result is Success) {
        List<dynamic> usersJson = jsonDecode(result.body) as List<dynamic>;
        List<Profile> users =
            usersJson.map((e) => Profile.fromJson(e)).toList();
        for (var element in users) {
          print("list user: ${element.username}");
        }
        emit(SearchState(profiles: users));
      } else if (result is Failure) {
        print('error search - ${result.body}');
        emit(SearchFailure(profiles: state.profiles));
      }
    } catch (err) {
      print('error search - $err');
      emit(SearchFailure(profiles: state.profiles));
    } finally {
      emit(SearchFinish(profiles: state.profiles));
    }
  }
}
