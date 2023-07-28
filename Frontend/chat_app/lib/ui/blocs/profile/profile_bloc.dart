import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:seller_app/model/profile.dart';
import 'package:seller_app/ui/blocs/profile/profile_event.dart';

import '../../../storages/storage.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc()
      : super(ProfileState(
            profile: Profile(id: 0, username: "", password: "", avatar: "", fullName: ''))) {
    on<InitProfileEvent>(_initProfileEvent);
  }

  FutureOr<void> _initProfileEvent(event, Emitter<ProfileState> emit) async {
    final value = await Storage.getMyProfile();
    Profile profile = Profile.fromRawJson(value ?? "");
    print("profile.avatar: ${profile.avatar}");
    emit(ProfileInitial(profile: profile));
  }
}
