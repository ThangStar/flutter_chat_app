part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class HandleSearchEvent extends SearchEvent {
  final String query;

  const HandleSearchEvent({required this.query});
}
