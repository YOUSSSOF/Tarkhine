part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrdersFetchedState extends OrderState {
  final List<OrderModel>? orders;
  const OrdersFetchedState({
    this.orders,
  });
}

class OrderItemLoadingState extends OrderState {}

class OrderErrorState extends OrderState {
  final Exception exception;
  const OrderErrorState({
    required this.exception,
  });
}

abstract class OrderActionState extends OrderState {}
