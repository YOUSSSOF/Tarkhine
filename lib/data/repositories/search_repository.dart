import 'package:tarkhine/data/models/food_model.dart';
import 'package:tarkhine/data/repositories/config.dart';
import 'package:tarkhine/data/repositories/delivery_repository.dart';

class SearchRepository extends Repository {
  Future<List<FoodModel>?> search(String? value) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return foods.where((food) => food.name.contains(value!)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
