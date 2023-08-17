import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
    import '../../core/constants/enums.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  late final Connectivity connectivity;
  InternetCubit() : super(InternetLoadingState()) {
    connectivity = Connectivity();
    connectivity.onConnectivityChanged.listen((result) {
      switch (result) {
        case ConnectivityResult.wifi:
          emit(const InternetConnectedState(InternetConnectionType.wifi));
        case ConnectivityResult.mobile:
          emit(const InternetConnectedState(InternetConnectionType.mobile));
        case ConnectivityResult.ethernet:
          emit(const InternetConnectedState(InternetConnectionType.ethernet));
        case ConnectivityResult.vpn:
          emit(const InternetConnectedState(InternetConnectionType.vpn));
        case ConnectivityResult.none:
          emit(InternetDisconnectedState());
        default:
      }
    });
  }
}
