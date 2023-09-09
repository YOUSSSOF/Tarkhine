import 'dart:convert';
import 'package:tarkhine/data/models/food_model.dart';
import 'package:tarkhine/data/repositories/config.dart';
import 'package:http/http.dart';

class SearchRepository extends Repository {
  Future<List<FoodModel>?> search(String? value) async {
    try {
      List<FoodModel> result = [];
      Response response = await client.get(foodsSearchEndpoint(value!));
      if (response.statusCode == 200) {
        List data = json.decode(utf8.decode(response.bodyBytes));
        for (Map<String, dynamic> map in data) {
          FoodModel food = FoodModel.fromMap(map);
          result.add(food);
        }
      } else {
        throw Exception();
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
