part of 'internet_cubit.dart';

abstract class InternetState extends Equatable {
  const InternetState();

  @override
  List<Object> get props => [];
}

class InternetLoadingState extends InternetState {}

class InternetConnectedState extends InternetState {
  final InternetConnectionType internetConnectionType;

  const InternetConnectedState(this.internetConnectionType);
}

class InternetDisconnectedState extends InternetState {}
