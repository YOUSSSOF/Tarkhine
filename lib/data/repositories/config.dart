import 'package:http/http.dart' as http;

abstract class Repository {
  final String serverUrl = '';
  final http.Client _client = http.Client();
  http.Client get client => _client;
  String get foodsEndpoint => '$serverUrl/foods';
  String get mainBannersEndpoint => '$serverUrl/mainBanners';
}
