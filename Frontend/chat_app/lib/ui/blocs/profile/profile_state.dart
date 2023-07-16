part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({required this.profile});
  final Profile profile;
  @override
  // TODO: implement props
  List<Object?> get props => [profile];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial({required super.profile});
}
