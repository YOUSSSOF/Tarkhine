import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarkhine/common/common.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/authentication_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial()) {
    authenticateUser();
  }

  UserModel? _user;
  UserModel? get user => _user;

  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  void checkIfIsFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 3));
    if (prefs.getBool('isFirst').nullOrNot) {
      await prefs.setBool('isFirst', true);
      emit(AuthenticationFailedNavigateToAuthActionState());
      emit(AuthenticationFailedNavigateToIntroductionActionState());
    } else {
      emit(AuthenticationFailedNavigateToAuthActionState());
    }
  }

  void sendSMS(String mobileNumber) async {
    if (state is AuthenticationLoadingState) return;
    try {
      emit(AuthenticationLoadingState());
      await _authenticationRepository.sendSMS(mobileNumber);
      emit(AuthenticationSentNavigateToVerifyActionState(mobileNumber));
      emit(AuthenticationInitial());
    } catch (e) {
      print(e);
      emit(AuthenticationErrorState(e as Exception));
      emit(AuthenticationInitial());
    }
  }

  void verifyCode(String code, String phoneNumber) async {
    if (state is AuthenticationLoadingState) return;
    try {
      emit(AuthenticationLoadingState());
      _user = await _authenticationRepository.verifyCode(code, phoneNumber);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', _user!.token ?? '');
      emit(AuthenticationSucceedVerificationState(_user!));
    } catch (e) {
      emit(AuthenticationErrorState(e as Exception));
    }
  }

  void authenticateUser() async {
    String? token;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token');
      if (token == null || token == '') {
        checkIfIsFirstTime();
        return;
      }
      _user = await _authenticationRepository.authenticateUser(token);
      emit(AuthenticationSuccedNavigateToAuthActionState());
      emit(AuthenticationSucceedVerificationState(_user!));
    } catch (e) {
      if (token != null) {
        emit(AuthenticationInternetErrorState());
        emit(AuthenticationInternetErrorActionState());
        return;
      }
      checkIfIsFirstTime();
      return;
    }
  }

  void updateUser({
    String? firstName,
    String? lastName,
    String? emailAddress,
    required phoneNumber,
    String? username,
  }) async {
    if (state is AuthenticationLoadingState) return;
    try {
      emit(AuthenticationLoadingState());
      _user = await _authenticationRepository.updateUser(
        user: user!,
        firstName: firstName,
        lastName: lastName,
        emailAddress: emailAddress,
        phoneNumber: phoneNumber,
        username: username,
      );

      emit(AuthenticationSucceedVerificationState(_user!));
    } catch (e) {
      print(e);
      emit(AuthenticationErrorState(Exception(e)));
    }
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    emit(AuthenticationSuccedNavigateToAuthActionState());
  }
}
