import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:seller_app/utils/response.dart';

import '../../../api/api.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginAuth>(_loginAuth);
  }

  FutureOr<void> _loginAuth(LoginAuth event, Emitter<AuthState> emit) async{
    print('here');
    Object object = await Api.login(event.username, event.password);
    if(object is Success){
      print("success: $object");
    }else {
     print("failure: $object");
    }
  }
}
