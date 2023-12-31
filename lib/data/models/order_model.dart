import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:tarkhine/core/constants/enums.dart';
import 'package:tarkhine/data/models/food_model.dart';

class OrderItemModel {
  final int id;
  final FoodModel food;
  final int quantity;
  OrderItemModel({
    required this.id,
    required this.food,
    required this.quantity,
  });

  OrderItemModel copyWith({
    int? id,
    FoodModel? food,
    int? quantity,
    int? userId,
  }) {
    return OrderItemModel(
      id: id ?? this.id,
      food: food ?? this.food,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'food': food.toMap()});
    result.addAll({'quantity': quantity});

    return result;
  }

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      id: map['id']?.toInt() ?? 0,
      food: FoodModel.fromMap(map['food']),
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItemModel.fromJson(String source) =>
      OrderItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderItemModel(id: $id, food: $food, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderItemModel &&
        other.id == id &&
        other.food == food &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^ food.hashCode ^ quantity.hashCode;
  }
}

class OrderModel {
  final int id;
  final String orderDate;
  final String address;
  final OrderStatus orderStatus;
  final bool deliverWithDelivery;
  final List<OrderItemModel> items;
  OrderModel({
    required this.id,
    required this.orderDate,
    required this.address,
    required this.orderStatus,
    required this.deliverWithDelivery,
    required this.items,
  });

  OrderModel copyWith({
    int? id,
    String? orderDate,
    String? address,
    OrderStatus? orderStatus,
    bool? deliverWithDelivery,
    List<OrderItemModel>? items,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderDate: orderDate ?? this.orderDate,
      address: address ?? this.address,
      orderStatus: orderStatus ?? this.orderStatus,
      deliverWithDelivery: deliverWithDelivery ?? this.deliverWithDelivery,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'order_date': orderDate});
    result.addAll({'address': address});
    result.addAll({'order_status': orderStatus});
    result.addAll({'deliver_with_delivery': deliverWithDelivery});
    result.addAll({'items': items.map((x) => x.toMap()).toList()});

    return result;
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id']?.toInt() ?? 0,
      orderDate: map['orderDate'],
      address: map['address'] ?? '',
      orderStatus: OrderStatus.pending,
      deliverWithDelivery: map['deliverWithDelivery'] ?? false,
      items: List<OrderItemModel>.from(
          map['items']?.map((x) => OrderItemModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(id: $id, orderDate: $orderDate, address: $address, orderStatus: $orderStatus, deliverWithDelivery: $deliverWithDelivery, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        other.id == id &&
        other.orderDate == orderDate &&
        other.address == address &&
        other.orderStatus == orderStatus &&
        other.deliverWithDelivery == deliverWithDelivery &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        orderDate.hashCode ^
        address.hashCode ^
        orderStatus.hashCode ^
        deliverWithDelivery.hashCode ^
        items.hashCode;
  }
}
