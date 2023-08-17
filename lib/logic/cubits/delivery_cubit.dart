import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tarkhine/common/common.dart';
import '../../data/repositories/delivery_repository.dart';
import '../../presentation/screens/home/widgets/main_banner_slider.dart';

import '../../data/models/food_model.dart';

part 'delivery_state.dart';

class DeliveryCubit extends Cubit<DeliveryState> {
  DeliveryCubit() : super(const DeliveryState()) {
    fetchDeliveryData();
    stream.listen((event) {
      if (!state.mainFoods.nullOrNot) {
        likedFoods =
            state.mainFoods!.where((FoodModel f) => f.isLiked).toList();
      }
    });
  }

  final DeliveryRepository _deliveryRepository = DeliveryRepository();
  List<FoodModel> likedFoods = [];

  Future<void> fetchDeliveryData() async {
    try {
      emit(state.copyWith(isLoading: true));
      List<Banner> mainBanners = await _deliveryRepository.fetchMainBanners();
      List<FoodModel> foods = await _deliveryRepository.fetchMainFoods();
      emit(state.copyWith(
        isLoading: false,
        banners: mainBanners,
        mainFoods: foods,
      ));
    } catch (e) {
      emit(state.copyWith(exception: e as Exception));
    }
  }

  Future<void> fetchMenuItems({bool reFeth = false}) async {
    try {
      if (!state.menuFoods.nullOrNot && !reFeth) return;
      emit(state.copyWith(isLoading: true));
      List<FoodModel> menuFoods = await _deliveryRepository.fetchMainFoods();
      emit(state.copyWith(
        isLoading: false,
        menuFoods: menuFoods,
      ));
    } catch (e) {
      emit(state.copyWith(exception: e as Exception));
    }
  }

  void likeFood(FoodModel food) async {
    try {
      await _deliveryRepository.likeFood(food);

      emit(state.copyWith(
        emit: !state.emit,
        mainFoods: state.mainFoods!.map((f) {
          if (f.id == food.id) f.isLiked = !f.isLiked;
          return f;
        }).toList(),
      ));
    } catch (e) {
      emit(state.copyWith(exception: e as Exception));
    }
  }

  void filterLikedFoods(String filter) {
    List<FoodModel> filteredList =
        likedFoods.where((FoodModel f) => f.name.contains(filter)).toList();
    filteredList.isEmpty && filter == ''
        ? likedFoods = likedFoods.where((FoodModel f) => f.isLiked).toList()
        : likedFoods.isEmpty
            ? []
            : likedFoods = filteredList;

    emit(state.copyWith(emit: !state.emit));
  }
}
