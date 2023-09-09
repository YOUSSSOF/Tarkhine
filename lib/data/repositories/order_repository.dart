import 'dart:convert';

import 'package:http/http.dart';
import 'package:tarkhine/core/core.dart';
import 'package:tarkhine/data/models/order_model.dart';
import 'package:tarkhine/data/models/user_model.dart';
import 'package:tarkhine/data/repositories/config.dart';

class OrderRepository extends Repository {
  Future<void> postOrder(
      UserModel user, String address, bool deliveryWithDelivery) async {
    try {
      Response postResponse = await client.post(myOrdersEndpoint, body: {
        'address': address,
        'order_status': 'pending',
        'deliver_with_delivery': deliveryWithDelivery.toString(),
        'user': user.id.toString(),
      }, headers: {
        'Authorization': 'Bearer ${user.token!}'
      });
      if (postResponse.statusCode == 200) {
      } else {
        throw Exception(postResponse.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OrderModel>> getOrders(UserModel user) async {
    try {
      List<OrderModel> orders = [];
      Response getResponse = await client.get(myOrdersEndpoint,
          headers: {'Authorization': 'Bearer ${user.token!}'});
      if (getResponse.statusCode == 200) {
        List results = json.decode(utf8.decode(getResponse.bodyBytes));
        for (Map result in results) {
          OrderModel order = OrderModel(
            id: result['id'],
            orderDate: result['order_date'],
            address: result['address'],
            orderStatus: OrderStatus.pending,
            deliverWithDelivery: result['deliver_with_delivery'],
            items: [],
          );
          for (Map<String, dynamic> itemResult in result['items']) {
            OrderItemModel orderItem = OrderItemModel.fromMap(itemResult);
            order.items.add(orderItem);
          }
          orders.add(order);
        }
        return orders;
      } else {
        throw Exception(getResponse.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteOrder(OrderModel order) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      rethrow;
    }
  }
}
