import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'person_chated_event.dart';
part 'person_chated_state.dart';

class PersonChatedBloc extends Bloc<PersonChatedEvent, PersonChatedState> {
  PersonChatedBloc() : super(PersonChatedInitial()) {
    on<PersonChatedEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
