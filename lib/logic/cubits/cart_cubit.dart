import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tarkhine/common/common.dart';
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
      emit(CartErrorActionState(exception: e as Exception));
    }
  }

  void addToCart(FoodModel food) async {
    if (state is CartItemLoadingState) return;
    emit(CartItemLoadingState(foodId: food.id));
    try {
      await _cartRepository.addToCart(food);
      if (!_cart.nullOrNot && isInCart(food).$1) {
        increaseQuantity(isInCart(food).$2!);
      } else {
        lastIndex = _cart.items.last.id;
        _cart = _cart.copyWith(
          items: [
            ..._cart.items,
            CartItemModel(
              id: !_cart.items.nullOrNot
                  ? (_cart.items.last.id + 1)
                  : lastIndex + 1,
              cartId: _cart.id,
              food: food,
            ),
          ],
        );
      }
      emit(CartAddedFoodActionState());
      emit(CartAddedFoodState(food: food));
    } catch (e) {
      // emit(CartErrorActionState(exception: e as Exception));
    }
  }

  void increaseQuantity(CartItemModel item) {
    _cart = cart.copyWith(
      items: _cart.items.map((e) {
        if (e.id == item.id) {
          emit(CartIncreasedQuantityState(
              foodId: e.food.id, newQuantity: e.quantity));
          return e.copyWith(quantity: item.quantity + 1);
        } else {
          return e;
        }
      }).toList(),
    );
  }

  void dereaseQuantity(CartItemModel item) {
    _cart = _cart.copyWith(
      items: _cart.items.map((e) {
        if (e.id == item.id && item.quantity > 0) {
          emit(CartIncreasedQuantityState(
              foodId: e.food.id, newQuantity: e.quantity));
          return e.copyWith(quantity: item.quantity - 1);
        } else {
          return e;
        }
      }).toList(),
    );
  }

  (bool, CartItemModel?) isInCart(FoodModel food) {
    return (
      _cart.items.any((element) => element.food.id == food.id),
      _cart.items.where((element) => element.id == food.id).firstOrNull
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
