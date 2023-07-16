import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:seller_app/model/login_response.dart';
import 'package:seller_app/model/profile.dart';
import 'package:seller_app/storages/storage.dart';
import 'package:seller_app/utils/response.dart';

import '../../../api/api.dart';
import '../profile/profile_event.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginAuth>(_loginAuth);
    on<InitEventFillData>(_initEventFillData);
  }

  FutureOr<void> _loginAuth(LoginAuth event, Emitter<AuthState> emit) async {
    emit(LoadingLogin());
    Object object = await Api.login(event.username, event.password);
    if (object is Success) {
      LoginResponse loginResponse = LoginResponse.fromRawJson(object.body);
      print(loginResponse.message);
      String jsonProfile = jsonEncode(loginResponse.profile.toJson());
      await Storage.saveMyProfile(jsonProfile);
      emit(LoginSuccess());
    } else if (object is Failure) {
      emit(LoginFailure());
    }
  }

  FutureOr<void> _initEventFillData(
      InitEventFillData event, Emitter<AuthState> emit) async {
    String? myProfile = await Storage.getMyProfile();
    if (myProfile != null) {
      Profile profile = Profile.fromRawJson(myProfile);
      emit(DataLogin(
          controllerUsername: TextEditingController(text: profile.username),
          controllerPassword: TextEditingController(text: profile.password)));
    }
  }
}
