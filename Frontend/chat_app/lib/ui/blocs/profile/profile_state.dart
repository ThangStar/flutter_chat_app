part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({required this.profile});
  final Profile profile;
  @override
  // TODO: implement props
  List<Object?> get props => [profile];
}

class ProgressUpdateAvatarProfileState extends ProfileState {
  const ProgressUpdateAvatarProfileState({required super.profile});
}

class FinishUpdateAvatarProfileState extends ProfileState {
  const FinishUpdateAvatarProfileState({required super.profile});
}
