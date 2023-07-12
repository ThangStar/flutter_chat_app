import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitProfileEvent extends ProfileEvent {}
