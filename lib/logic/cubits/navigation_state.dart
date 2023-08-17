part of 'navigation_cubit.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class NavigationLoadingState extends NavigationState {
  const NavigationLoadingState();

  @override
  List<Object> get props => [];
}

class NavigationIndexState extends NavigationState {
  final int index;

  const NavigationIndexState(this.index);
  @override
  List<Object> get props => [index];
}
