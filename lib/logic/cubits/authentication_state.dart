part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}

@immutable
abstract class AuthenticationActionState extends AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}
class AuthenticationInternetErrorState
    extends AuthenticationState {}


class AuthenticationFailedNavigateToAuthActionState
    extends AuthenticationActionState {}

class AuthenticationFailedNavigateToIntroductionActionState
    extends AuthenticationActionState {}

class AuthenticationSentNavigateToVerifyActionState
    extends AuthenticationActionState {
  final String phoneNumbr;

  AuthenticationSentNavigateToVerifyActionState(this.phoneNumbr);
}

class AuthenticationSucceedVerificationState extends AuthenticationActionState {
  final UserModel user;
  AuthenticationSucceedVerificationState(this.user);
}

class AuthenticationUserUpdatedState extends AuthenticationActionState {
  final UserModel user;
  AuthenticationUserUpdatedState(this.user);
}

class AuthenticationSuccedNavigateToHomeActionState
    extends AuthenticationActionState {}

class AuthenticationSuccedNavigateToAuthActionState
    extends AuthenticationActionState {}

class AuthenticationErrorState extends AuthenticationState {
  final Exception error;

  AuthenticationErrorState(this.error);
}

class AuthenticationInternetErrorActionState extends AuthenticationActionState {}
