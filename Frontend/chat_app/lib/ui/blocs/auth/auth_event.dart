part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginAuth extends AuthEvent {
  final String username;
  final String password;

  const LoginAuth({required this.username, required this.password});
}

class InitEventFillData extends AuthEvent {}
