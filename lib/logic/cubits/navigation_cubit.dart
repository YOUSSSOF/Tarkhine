import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationIndexState(4));
  void changeIndex(int index) {
    emit(const NavigationLoadingState());
    emit(NavigationIndexState(index));
  }
}
