import 'dart:convert';
import 'package:tarkhine/core/core.dart';
import 'package:http/http.dart';
import '../models/food_model.dart';
import 'config.dart';
import '../../presentation/screens/home/widgets/main_banner_slider.dart';

class DeliveryRepository extends Repository {
  Future<List<Banner>> fetchMainBanners() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return banners;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<FoodModel>> fetchMainFoods() async {
    try {
      List<FoodModel> result = [];
      Response response = await client.get(foodsEndpoint);

      if (response.statusCode == 200) {
        List data = json.decode(utf8.decode(response.bodyBytes));
        for (Map<String, dynamic> map in data) {
          FoodModel food = FoodModel.fromMap(map);
          switch (map['food_tag']) {
            case 'perisan':
              food.tag = FoodTag.persian;
            case 'nonPerisan':
              food.tag = FoodTag.nonPersian;
            case 'pizza':
              food.tag = FoodTag.pizza;
            case 'sandwich':
              food.tag = FoodTag.sandwich;
            case 'special':
              food.tag = FoodTag.special;
            case 'inMenu':
              food.tag = FoodTag.inMenu;
            default:
              food.tag = FoodTag.normal;
          }
          result.add(food);
        }

        return result;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  Future<List<FoodModel>> fetchMenuFoods() async {
    try {
      List<FoodModel> result = [];
      Response response = await client.get(foodsEndpoint);

      if (response.statusCode == 200) {
        List data = json.decode(utf8.decode(response.bodyBytes));
        for (Map<String, dynamic> map in data) {
          FoodModel food = FoodModel.fromMap(map);
          switch (map['food_tag']) {
            case 'persian':
              food.tag = FoodTag.persian;
            case 'nonPerisan':
              food.tag = FoodTag.nonPersian;
            case 'pizza':
              food.tag = FoodTag.pizza;
            case 'sandwich':
              food.tag = FoodTag.sandwich;
            case 'special':
              food.tag = FoodTag.special;
            case 'inMenu':
              food.tag = FoodTag.inMenu;
            default:
              food.tag = FoodTag.normal;
          }
          print(food.thumbnail);
          result.add(food);
        }
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> likeFood(FoodModel food) async {}
}

List<Banner> banners = [
  Banner(
      banner: Assets.images.slider1,
      title: 'یک ماجراجویی آشپزی برای تمام حواس'),
  Banner(banner: Assets.images.slider2, title: 'هر روز، یک تجربه مزه جدید'),
  Banner(
      banner: Assets.images.slider3, title: 'تجربه‌ای که فراموش نخواهید کرد'),
  Banner(banner: Assets.images.slider4, title: 'طعم بی‌نظیر طبیعت!'),
  Banner(banner: Assets.images.slider5, title: 'یک وعده غذایی ساده با هم'),
  Banner(banner: Assets.images.slider6, title: 'طعمی که به یاد خواهید آورد'),
];
