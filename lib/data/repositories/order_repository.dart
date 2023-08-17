import 'package:tarkhine/core/core.dart';
import 'package:tarkhine/data/models/order_model.dart';
import 'package:tarkhine/data/models/user_model.dart';
import 'package:tarkhine/data/repositories/config.dart';
import 'package:tarkhine/data/repositories/delivery_repository.dart';

class OrderRepository extends Repository {
  Future<List<OrderModel>> getOrders(UserModel user) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return [
        OrderModel(
          id: 1,
          deliverWithDelivery: false,
          orderDate: DateTime.now(),
          address: 'تهران: اقدسیه، بزرگراه ارتش، مجتمع شمیران سنتر، طبقه ۱۰',
          orderStatus: OrderStatus.pending,
          items: [
            OrderItemModel(id: 1, food: foods[0], quantity: 20, userId: 1),
            OrderItemModel(id: 2, food: foods[3], quantity: 5, userId: 1),
            OrderItemModel(id: 3, food: foods[2], quantity: 1, userId: 1),
            OrderItemModel(id: 4, food: foods[1], quantity: 1, userId: 1),
            OrderItemModel(id: 5, food: foods[4], quantity: 2, userId: 1),
          ],
        ),
        OrderModel(
          id: 2,
          deliverWithDelivery: true,
          orderDate: DateTime.now(),
          address: 'تهران: اقدسیه، بزرگراه ارتش، مجتمع شمیران سنتر، طبقه ۱۰',
          orderStatus: OrderStatus.delivered,
          items: [
            OrderItemModel(id: 1, food: foods[0], quantity: 20, userId: 1),
            OrderItemModel(id: 2, food: foods[3], quantity: 5, userId: 1),
            OrderItemModel(id: 3, food: foods[2], quantity: 1, userId: 1),
            OrderItemModel(id: 4, food: foods[1], quantity: 1, userId: 1),
            OrderItemModel(id: 5, food: foods[4], quantity: 2, userId: 1),
          ],
        ),
      ];
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
