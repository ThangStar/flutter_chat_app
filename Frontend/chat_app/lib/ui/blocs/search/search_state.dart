part of 'search_bloc.dart';

class SearchState extends Equatable {
  final List<Profile> profiles;
  const SearchState({required this.profiles});
  @override
  List<Object> get props => [profiles];
}

class SearchInitial extends SearchState {
  const SearchInitial({required super.profiles});
}

class SearchProgress extends SearchState {
  const SearchProgress({required super.profiles});
}

class SearchSuccess extends SearchState {
  const SearchSuccess({required super.profiles});
}

class SearchFailure extends SearchState {
  const SearchFailure({required super.profiles});
}

class SearchFinish extends SearchState {
  const SearchFinish({required super.profiles});
}
