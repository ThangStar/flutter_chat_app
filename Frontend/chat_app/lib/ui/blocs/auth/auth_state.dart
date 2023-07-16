part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}
class LoadingLogin extends AuthInitial{

}
class LoginSuccess extends AuthInitial{
}
class LoginFailure extends AuthInitial{
}
class DataLogin extends AuthState{
  final TextEditingController controllerUsername;
  final TextEditingController controllerPassword;
  @override
  // TODO: implement props
  List<Object?> get props => [controllerUsername, controllerPassword];

  const DataLogin({required this.controllerUsername, required this.controllerPassword});
}