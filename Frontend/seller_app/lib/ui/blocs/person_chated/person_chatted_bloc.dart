import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:seller_app/api/api.dart';
import 'package:seller_app/utils/response.dart';

part 'person_chatted_event.dart';
part 'person_chatted_state.dart';

class PersonChatedBloc extends Bloc<PersonChattedEvent, PersonChattedState> {
  PersonChatedBloc() : super(PersonChattedInitial()) {
    on<InitPersonChatted>(_initPersonChated);
  }

  FutureOr<void> _initPersonChated(InitPersonChatted event, Emitter<PersonChattedState> emit) async{
    Object res = await Api.getAllMessageOfUser("id");
    if(res is Success){
      print(res.body);
    }else if(res is Failure){
      print("ERR");
    }
  }
}
