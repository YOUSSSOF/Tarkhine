import 'package:tarkhine/data/models/cart_model.dart';
import 'package:tarkhine/data/models/food_model.dart';
import 'package:tarkhine/data/models/user_model.dart';
import 'package:tarkhine/data/repositories/config.dart';
import 'package:tarkhine/data/repositories/delivery_repository.dart';

class CartRepository extends Repository {
  Future<CartModel> getCart(UserModel user) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return CartModel(
        id: 1,
        userId: user.id,
        items: [
          CartItemModel(id: 1, cartId: 1, food: foods[0], quantity: 1),
          CartItemModel(id: 2, cartId: 1, food: foods[1], quantity: 2),
          CartItemModel(id: 3, cartId: 1, food: foods[2], quantity: 1),
          CartItemModel(id: 4, cartId: 1, food: foods[3], quantity: 1),
          CartItemModel(id: 5, cartId: 1, food: foods[4], quantity: 2),
          CartItemModel(id: 6, cartId: 1, food: foods[5], quantity: 1),
        ],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addToCart(FoodModel food) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> applyDiscountCode(String code) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      rethrow;
    }
  }
}
