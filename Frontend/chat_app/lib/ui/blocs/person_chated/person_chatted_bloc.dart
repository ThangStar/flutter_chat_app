import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:seller_app/api/api.dart';
import 'package:seller_app/model/profile.dart';
import 'package:seller_app/storages/storage.dart';
import 'package:seller_app/utils/response.dart';

import '../../../model/person_chatted.dart';
import '../../../utils/spacing_date_to_now.dart';

part 'person_chatted_event.dart';

part 'person_chatted_state.dart';

class PersonChattedBloc extends Bloc<PersonChattedEvent, PersonChattedState> {
  PersonChattedBloc() : super(const PersonChattedState(persons: [])) {
    on<InitPersonChatted>(_initPersonChatted);
  }

  FutureOr<void> _initPersonChatted(
      InitPersonChatted event, Emitter<PersonChattedState> emit) async {
    String? jsonProfile = await Storage.getMyProfile();

    Profile profile = Profile.fromRawJson(jsonProfile ?? "null");

    Object res = await Api.getAllMessageOfUser(profile.id);
    if (res is Success) {
      List<dynamic> jsonMessages = (json.decode(res.body));
      List<PersonChatted> persons = [];
      for (var e in jsonMessages) {
        PersonChatted person = PersonChatted.fromJson(e);
        String spacingTime = spacingDateToNow(DateTime.parse(person.dateTime));
        person.dateTime = spacingTime;
        persons.add(person);
      }
      emit(PersonChattedState(persons: persons));
    } else if (res is Failure) {
      print("ERR");
    }
  }
}
