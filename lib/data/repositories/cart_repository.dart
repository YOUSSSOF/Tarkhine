import 'dart:convert';

import 'package:tarkhine/data/models/cart_model.dart';
import 'package:tarkhine/data/models/food_model.dart';
import 'package:tarkhine/data/models/user_model.dart';
import 'package:tarkhine/data/repositories/config.dart';
import 'package:http/http.dart';

class CartRepository extends Repository {
  Future<CartModel> getCart(UserModel user) async {
    try {
      Response response = await client.get(myCartEndpoint,
          headers: {'Authorization': 'Bearer ${user.token!}'});
      if (response.statusCode == 200) {
        Map data = json.decode(utf8.decode(response.bodyBytes));
        CartModel cart = CartModel(id: data['id'], userId: user.id, items: []);
        List<CartItemModel> items = [];
        for (Map itemData in data['items']) {
          CartItemModel item = CartItemModel(
            id: itemData['id'],
            cartId: cart.id,
            food: FoodModel.fromMap(itemData['food']),
            quantity: itemData['quantity'],
          );
          items.add(item);
        }
        cart.items = items;
        return cart;
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CartItemModel>> addToCart(
      FoodModel food, CartModel cart, UserModel user) async {
    try {
      Response addResponse = await client.post(myCartAddItemEndpoint,
          body: {'food': food.id.toString()},
          headers: {'Authorization': 'Bearer ${user.token!}'});
      if (addResponse.statusCode == 201) {
        Response itemsResponse = await client.get(myCartItemsEndpoint,
            headers: {'Authorization': 'Bearer ${user.token!}'});
        if (itemsResponse.statusCode == 200) {
          List<CartItemModel> items = [];
          for (Map itemData
              in json.decode(utf8.decode(itemsResponse.bodyBytes))) {
            CartItemModel item = CartItemModel(
              id: itemData['id'],
              cartId: cart.id,
              food: FoodModel.fromMap(itemData['food']),
              quantity: itemData['quantity'],
            );
            items.add(item);
          }
          return items;
        } else {
          throw Exception(itemsResponse.body);
        }
      } else {
        throw Exception(addResponse.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CartItemModel>> removeFromCart(
      CartItemModel cartItem, UserModel user) async {
    try {
      Response deleteResponse = await client.delete(
          myCartDeleteItemEndpoint(cartItem.id),
          headers: {'Authorization': 'Bearer ${user.token!}'});
      print(myCartDeleteItemEndpoint(cartItem.id));
      if (deleteResponse.statusCode == 204 ||
          deleteResponse.statusCode == 200) {
        Response itemsResponse = await client.get(myCartItemsEndpoint,
            headers: {'Authorization': 'Bearer ${user.token!}'});
        if (itemsResponse.statusCode == 200) {
          List<CartItemModel> items = [];
          for (Map itemData
              in json.decode(utf8.decode(itemsResponse.bodyBytes))) {
            CartItemModel item = CartItemModel(
              id: itemData['id'],
              cartId: cartItem.cartId,
              food: FoodModel.fromMap(itemData['food']),
              quantity: itemData['quantity'],
            );
            items.add(item);
          }
          return items;
        } else {
          throw Exception(itemsResponse.body);
        }
      } else {
        throw Exception(deleteResponse.body);
      }
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
