part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitialState extends CartState {
  @override
  List<Object?> get props => [];

}

class CartLoadingState extends CartState {
  const CartLoadingState();
  @override
  List<Object?> get props => [];
}

class CartUpdatedState extends CartState {
  final CartModel? cart;
  const CartUpdatedState({
    this.cart,
  });

  @override
  List<Object?> get props => [cart];
}

class CartItemLoadingState extends CartState {
  final int? foodId;
  const CartItemLoadingState({
    this.foodId,
  });
  @override
  List<Object?> get props => throw [foodId];
}

class CartAddedFoodState extends CartState {
  final FoodModel food;
  const CartAddedFoodState({
    required this.food,
  });

  @override
  List<Object?> get props => [food];
}

class CartIncreasedQuantityState extends CartState {
  final int foodId;
  final int newQuantity;
  const CartIncreasedQuantityState({
    required this.foodId,
    required this.newQuantity,
  });
  @override
  List<Object?> get props => [foodId, newQuantity];
}

class CartDecreasedQuantityState extends CartState {
  final int foodId;

  final int newQuantity;
  const CartDecreasedQuantityState({
    required this.foodId,
    required this.newQuantity,
  });

  @override
  List<Object?> get props => [foodId, newQuantity];
}

class CartApplyingDiscountCodeLoadingState extends CartState {
  final String code;
  const CartApplyingDiscountCodeLoadingState({
    required this.code,
  });
  @override
  List<Object?> get props => [code];
}

abstract class CartActionState extends CartState {}

class CartAddedFoodActionState extends CartActionState {
  @override
  List<Object?> get props => [];
}

class CartErrorActionState extends CartActionState {
  final Exception exception;
  CartErrorActionState({
    required this.exception,
  });

  @override
  List<Object?> get props => [];
}

class CartDiscountAlreadyAppliedActionState extends CartActionState {
  @override
  List<Object?> get props => [];
}

class CartDiscountNotValidActionState extends CartActionState {
  @override
  List<Object?> get props => [];
}

class CartApplyedDiscountCodeSuccessgfullyActionState extends CartState {
  @override
  List<Object?> get props => [];
}
