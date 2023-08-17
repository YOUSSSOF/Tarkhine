import '../models/user_model.dart';

class AuthenticationRepository {
  Future<void> sendSMS(String mobileNumber) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      throw Exception('مشکلی پیش آمده است.');
    }
  }

  Future<UserModel> verifyCode(String code, String phoneNumber) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      UserModel user = UserModel(
        id: 1,
        phoneNumber: phoneNumber,
        token: '1111-1111-1111-1111',
      );
      return Future.value(user);
    } catch (e) {
      throw Exception('کد وارد شده صحیح نمی باشد.');
    }
  }

  Future<UserModel> authenticateUser(String? token) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      UserModel user = UserModel(
        id: 1,
        phoneNumber: '09135655644',
        token: '1111-1111-1111-1111',
      );
      return Future.value(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> updateUser({
    String? firstName,
    String? lastName,
    String? emailAddress,
    required String phoneNumber,
    String? username,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      UserModel user = UserModel(
        id: 1,
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
        email: emailAddress,
        username: username,
        token: '1111-1111-1111-1111',
      );
      return Future.value(user);
    } catch (e) {
      rethrow;
    }
  }
}
