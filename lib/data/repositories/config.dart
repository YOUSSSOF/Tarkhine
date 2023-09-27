import 'package:http/http.dart' as http;

abstract class Repository {
  static const  String serverUrl = 'your server url';
  String get apiUrl => '$serverUrl/api';
  final http.Client _client = http.Client();
  http.Client get client => _client;
  Uri get authCodeRequestEndpoint => Uri.parse('$apiUrl/auth/otp/request/');
  Uri get authCodeVerifyEndpoint => Uri.parse('$apiUrl/auth/otp/verify/');
  Uri get foodsEndpoint => Uri.parse('$apiUrl/foods/');
  Uri foodsSearchEndpoint(String search) =>
      Uri.parse('$apiUrl/foods/?search=$search');
  Uri get meEndpoint => Uri.parse('$apiUrl/auth/me/');
  Uri get meUpdateEndpoint => Uri.parse('$apiUrl/auth/me/');
  Uri get myCartEndpoint => Uri.parse('$apiUrl/auth/me/cart/');
  Uri get myCartItemsEndpoint => Uri.parse('$apiUrl/auth/me/cart/items/');
  Uri get myCartAddItemEndpoint => Uri.parse('$apiUrl/auth/me/cart/items/');
  Uri myCartDeleteItemEndpoint(int itemId) =>
      Uri.parse('$apiUrl/auth/me/cart/items/$itemId/');
  Uri get myOrdersEndpoint => Uri.parse('$apiUrl/auth/me/orders/');
}
