part of 'delivery_cubit.dart';

class DeliveryState extends Equatable {
  const DeliveryState({
    this.isLoading = false,
    this.emit = false,
    this.banners,
    this.mainFoods,
    this.menuFoods,
    this.exception,
  });
  final bool isLoading;
  final bool emit;
  final List<Banner>? banners;
  final List<FoodModel>? mainFoods;
  final List<FoodModel>? menuFoods;
  final Exception? exception;
  @override
  List<Object> get props => [isLoading, emit];

  DeliveryState copyWith({
    bool? isLoading,
    bool? emit,
    List<Banner>? banners,
    List<FoodModel>? mainFoods,
    List<FoodModel>? menuFoods,
    Exception? exception,
  }) {
    return DeliveryState(
      isLoading: isLoading ?? this.isLoading,
      emit: emit ?? this.emit,
      banners: banners ?? this.banners,
      mainFoods: mainFoods ?? this.mainFoods,
      menuFoods: menuFoods ?? this.menuFoods,
      exception: exception ?? this.exception,
    );
  }
}
