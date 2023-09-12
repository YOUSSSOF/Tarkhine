import 'dart:convert';

import 'package:tarkhine/data/repositories/config.dart';
import 'package:http/http.dart';
import '../models/user_model.dart';

class AuthenticationRepository extends Repository {
  Future<String> sendSMS(String mobileNumber) async {
    try {
      Response response = await client
          .post(authCodeRequestEndpoint, body: {'phone_number': mobileNumber});
      if (response.statusCode == 200) {
        return json.decode(response.body)['code'];
      } else {
        throw Exception('اختلال در سرور، لطفا دوباره تلاش کنید.');
      }
    } catch (e) {
      throw Exception('اختلال در سرور، لطفا دوباره تلاش کنید.');
    }
  }

  Future<UserModel> verifyCode(String code, String phoneNumber) async {
    try {
      Response verifyResponse = await client.post(authCodeVerifyEndpoint,
          body: {'phone_number': phoneNumber, 'verification_code': code});
      if (verifyResponse.statusCode == 200) {
        String accessToken = json.decode(verifyResponse.body)['access'];
        Response userResponse = await client
            .get(meEndpoint, headers: {'Authorization': 'Bearer $accessToken'});
        if (userResponse.statusCode == 200) {
          UserModel user = UserModel.fromJson(userResponse.body);
          user.token = accessToken;
          return Future.value(user);
        } else {
          throw Exception('اختلال در سرور، لطفا دوباره تلاش کنید.');
        }
      } else {
        throw Exception('اختلال در سرور، لطفا دوباره تلاش کنید.');
      }
    } catch (e) {
      throw Exception('کد وارد شده صحیح نمی باشد.');
    }
  }

  Future<UserModel> authenticateUser(String? token) async {
    try {
      Response userResponse = await client
          .get(meEndpoint, headers: {'Authorization': 'Bearer $token'});
      if (userResponse.statusCode == 200) {
        UserModel user =
            UserModel.fromJson(utf8.decode(userResponse.bodyBytes));
        user.token = token;
        return Future.value(user);
      } else if(userResponse.statusCode == 500) {
        throw Exception('invalid jwt');
      }else{
        throw Exception();

      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> updateUser({
    required UserModel user,
    String? firstName,
    String? lastName,
    String? emailAddress,
    String? phoneNumber,
    String? username,
  }) async {
    try {
      Response response = await client.put(meUpdateEndpoint, headers: {
        'Authorization': 'Bearer ${user.token!}'
      }, body: {
        "phone_number": (phoneNumber ?? user.phoneNumber).toString(),
        "first_name": (firstName ?? user.firstName).toString(),
        "last_name": (lastName ?? user.lastName).toString(),
        "email": (emailAddress ?? user.email).toString(),
        "username": (username ?? user.username).toString(),
      });
      if (response.statusCode == 200) {
        Map<String, dynamic> result =
            json.decode(utf8.decode(response.bodyBytes));
        return UserModel.fromMap(result);
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }
}
