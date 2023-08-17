import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tarkhine/data/models/order_model.dart';
import 'package:tarkhine/data/models/user_model.dart';
import 'package:tarkhine/data/repositories/order_repository.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(UserModel user) : super(OrderInitial()) {
    fetchOrders(user);
  }

  final OrderRepository _orderRepository = OrderRepository();
  List<OrderModel>? _orders;
  List<OrderModel>? get orders => _orders;

  void fetchOrders(UserModel user) async {
    if (state is OrderLoadingState) return;
    try {
      emit(OrderLoadingState());
      _orders = await _orderRepository.getOrders(user);
      emit(OrdersFetchedState(orders: _orders));
    } catch (e) {
      emit(OrderErrorState(exception: e as Exception));
    }
  }

  void deleteOrder(OrderModel order) async {
    if (state is OrderLoadingState) return;
    try {
      emit(OrderLoadingState());
      await _orderRepository.deleteOrder(order);
      _orders!.remove(order);
      emit(OrdersFetchedState(orders: _orders));
    } catch (e) {
      emit(OrderErrorState(exception: e as Exception));
    }
  }

  double calculateTotalOrderPrice(OrderModel order) {
    double total = 0;
    for (var item in order.items) {
      total += item.quantity * item.food.price;
    }
    return total - calculateDiscountOrderPrice(order);
  }

  double calculateDiscountOrderPrice(OrderModel order) {
    double discount = 0;
    for (var item in order.items) {
      discount += item.quantity * (item.food.discount / 100) * item.food.price;
    }
    return discount;
  }
}
