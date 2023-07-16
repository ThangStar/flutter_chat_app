part of 'person_chatted_bloc.dart';

abstract class PersonChattedEvent extends Equatable {
  const PersonChattedEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitPersonChatted extends PersonChattedEvent {
}
