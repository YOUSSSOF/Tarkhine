import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tarkhine/data/repositories/search_repository.dart';
import '../../data/models/food_model.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());
  final SearchRepository _searchRepository = SearchRepository();
  void search(String? value) async {
    if (value!.isEmpty || value == '') {
      emit(SearchInitialState());
      return;
    }
    if (state is! SearchLoadingState) {
      emit(SearchLoadingState());
    }
    try {
      final List<FoodModel>? results = await _searchRepository.search(value);
      if (results!.isEmpty && state is! SearchInitialState) {
        emit(SearchNotFoundActionState());
        emit(SearchInitialState());
        return;
      } else if (results.isNotEmpty) {
        emit(SearchSuccessState(results: results));
      }
    } catch (e) {
      emit(SearchErrorActionState(e as Exception));
      emit(SearchInitialState());
    }
  }
}
