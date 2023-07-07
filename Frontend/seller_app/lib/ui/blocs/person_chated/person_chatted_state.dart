part of 'person_chatted_bloc.dart';

 class PersonChattedState extends Equatable {
   final List<PersonChatted> persons;

   const PersonChattedState({required this.persons});
  @override
  List<Object> get props => [persons];
}


