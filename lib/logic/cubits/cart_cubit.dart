import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tarkhine/data/models/food_model.dart';
import 'package:tarkhine/data/models/user_model.dart';
import '../../data/models/cart_model.dart';
import '../../data/repositories/cart_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(UserModel user) : super(CartInitialState()) {
    fetchCartData(user);
    stream.listen((event) {
      _cart = _cart.copyWith(
        items: _cart.items.where((e) => e.quantity != 0).toList(),
      );
    });
  }
  late CartModel _cart;
  CartModel get cart => _cart;
  int lastIndex = 1;
  double discountPrice = 0;
  String discountCode = '';

  final CartRepository _cartRepository = CartRepository();
  Future<void> fetchCartData(UserModel user) async {
    if (state is CartLoadingState) return;
    emit(const CartLoadingState());
    try {
      _cart = await _cartRepository.getCart(user);
      emit(CartUpdatedState(cart: _cart));
    } catch (e) {
      emit(CartErrorActionState(exception: Exception()));
    }
  }

  void addToCart(FoodModel food, UserModel user) async {
    if (state is CartItemsLoadingState) return;
    emit(CartItemsLoadingState(foodId: food.id));
    try {
      _cart = cart.copyWith(
        items: await _cartRepository.addToCart(food, cart, user),
      );
      await fetchCartData(user);
      emit(CartAddedFoodActionState());
      emit(CartAddedFoodState(food: food));
    } catch (e) {
      emit(CartErrorActionState(exception: e as Exception));
    }
  }

  void increaseQuantity(CartItemModel item, UserModel user) async {
    if (state is CartItemsLoadingState) return;
    emit(CartItemsLoadingState(foodId: item.food.id));

    try {
      _cart = cart.copyWith(
        items: await _cartRepository.addToCart(item.food, cart, user),
      );
      await fetchCartData(user);
      emit(CartAddedFoodState(food: item.food));
    } catch (e) {
      emit(CartErrorActionState(exception: e as Exception));
    }
  }

  void dereaseQuantity(CartItemModel item, UserModel user) async {
    if (state is CartItemsLoadingState) return;
    emit(CartItemsLoadingState(foodId: item.food.id));

    try {
      _cart = cart.copyWith(
        items: await _cartRepository.removeFromCart(item, user),
      );
      await fetchCartData(user);
      emit(CartAddedFoodState(food: item.food));
    } catch (e) {
      emit(CartErrorActionState(exception: e as Exception));
    }
  }

  (bool, CartItemModel?) isInCart(FoodModel food) {
    return (
      _cart.items.any((element) => element.food.id == food.id),
      _cart.items.where((element) => element.food.id == food.id).firstOrNull
    );
  }

  double calculateTotalCartPrice({bool withDiscount = false}) {
    double total = 0;
    for (var item in _cart.items) {
      total += item.quantity * item.food.price;
    }
    return (withDiscount ? total - calculateDiscountCartPrice() : total) -
        discountPrice;
  }

  double calculateDiscountCartPrice() {
    double discount = 0;
    for (var item in _cart.items) {
      discount += item.quantity * (item.food.discount / 100) * item.food.price;
    }
    return discount;
  }

  void applyDiscountCode(String code) async {
    try {
      emit(CartApplyingDiscountCodeLoadingState(code: code));
      if (code == 'TARKHINE' && code != discountCode) {
        await _cartRepository.applyDiscountCode(code);
        discountCode = code;
        discountPrice = 29000;
        emit(CartApplyedDiscountCodeSuccessgfullyActionState());
      } else if (code == 'TARKHINE' && code == discountCode) {
        emit(CartDiscountAlreadyAppliedActionState());
      } else {
        emit(CartDiscountNotValidActionState());
      }
    } catch (e) {
      emit(CartErrorActionState(exception: e as Exception));
    }
  }
}
