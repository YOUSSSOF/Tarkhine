import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:tarkhine/data/models/food_model.dart';

class CartItemModel {
  final int id;
  final int cartId;
  final FoodModel food;
  final int quantity;

  CartItemModel({
    required this.id,
    required this.cartId,
    required this.food,
    this.quantity = 1,
  });

  CartItemModel copyWith({
    int? id,
    int? cartId,
    FoodModel? food,
    int? quantity,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      cartId: cartId ?? this.cartId,
      food: food ?? this.food,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'cartId': cartId});
    result.addAll({'food': food.toMap()});
    result.addAll({'quantity': quantity});

    return result;
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id']?.toInt() ?? 0,
      cartId: map['cartId']?.toInt() ?? 0,
      food: FoodModel.fromMap(map['food']),
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) =>
      CartItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartItem(id: $id, cartId: $cartId, food: $food, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItemModel &&
        other.id == id &&
        other.cartId == cartId &&
        other.food == food &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^ cartId.hashCode ^ food.hashCode ^ quantity.hashCode;
  }
}

class CartModel {
  final int id;
  final int userId;
  List<CartItemModel> items;
  CartModel({
    required this.id,
    required this.userId,
    required this.items,
  });

  CartModel copyWith({
    int? id,
    int? userId,
    List<CartItemModel>? items,
  }) {
    return CartModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'userId': userId});
    result.addAll({'items': items.map((x) => x.toMap()).toList()});

    return result;
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id']?.toInt() ?? 0,
      userId: map['userId']?.toInt() ?? 0,
      items: List<CartItemModel>.from(
          map['items']?.map((x) => CartItemModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source));

  @override
  String toString() => 'Cart(id: $id, userId: $userId, items: $items)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartModel &&
        other.id == id &&
        other.userId == userId &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode => id.hashCode ^ userId.hashCode ^ items.hashCode;
}
