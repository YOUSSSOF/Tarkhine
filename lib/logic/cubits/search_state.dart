part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  final List<FoodModel> results;
  const SearchSuccessState({
    required this.results,
  });
}

abstract class SearchActionState extends SearchState {}

class SearchNotFoundActionState extends SearchActionState {}

class SearchErrorActionState extends SearchActionState {
  final Exception exception;
  SearchErrorActionState(
    this.exception,
  );
}
