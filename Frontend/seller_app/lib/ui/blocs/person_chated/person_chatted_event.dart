part of 'person_chated_bloc.dart';

abstract class PersonChatedEvent extends Equatable {
  const PersonChatedEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitPersonChated extends PersonChatedEvent {
  final String myId;

  const InitPersonChated({required this.myId});
}
