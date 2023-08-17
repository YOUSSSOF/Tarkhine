import 'package:tarkhine/core/core.dart';

import '../../core/constants/assets.dart';
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
      await Future.delayed(const Duration(seconds: 2));
      return foods;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<FoodModel>> fetchMenuFoods() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return foods;
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

List<FoodModel> foods = [
  FoodModel(
    id: 1,
    name: 'دلمه برگ کلم',
    content: '',
    price: 209000,
    score: 5,
    tag: FoodTag.special,
  ),
  FoodModel(
    id: 2,
    name: 'بادمجان شکم‌پر',
    content: '',
    price: 150000,
    score: 4,
    thumbnail: Assets.images.food2,
    discount: 18,
    tag: FoodTag.favorite,
  ),
  FoodModel(
    id: 3,
    name: 'کالزونه اسفناج',
    content:
        'بادمجان، گوجه فرنگی، کدو سبز، پیاز، رب گوجه فرنگی، روغن زیتون، پنیر پارمزان',
    price: 177000,
    score: 3,
    thumbnail: Assets.images.food3,
    covers: [
      Assets.images.cover1,
      Assets.images.cover2,
      Assets.images.cover3,
    ],
    tag: FoodTag.nonPersian,
  ),
  FoodModel(
    id: 4,
    name: 'پیتزا قارچ',
    content: '',
    price: 175000,
    score: 3,
    thumbnail: Assets.images.food4,
    discount: 22,
    tag: FoodTag.special,
  ),
  FoodModel(
    id: 5,
    name: 'ساندویچ کتلت مخصوص',
    content: '',
    price: 205000,
    score: 5,
    thumbnail: Assets.images.food5,
    discount: 50,
    tag: FoodTag.nonPersian,
  ),
  FoodModel(
    id: 6,
    name: 'ساندویچ کتلت مخصوص',
    content: '',
    price: 205000,
    score: 5,
    thumbnail: Assets.images.food5,
    discount: 50,
    tag: FoodTag.special,
  ),
  FoodModel(
    id: 7,
    name: 'کالزونه اسفناج',
    content:
        'بادمجان، گوجه فرنگی، کدو سبز، پیاز، رب گوجه فرنگی، روغن زیتون، پنیر پارمزان',
    price: 177000,
    score: 3,
    thumbnail: Assets.images.food3,
    covers: [
      Assets.images.cover1,
      Assets.images.cover2,
      Assets.images.cover3,
    ],
    tag: FoodTag.nonPersian,
  ),
  FoodModel(
    id: 8,
    name: 'دلمه برگ کلم',
    content: '',
    price: 209000,
    score: 5,
    tag: FoodTag.favorite,
  ),
  FoodModel(
    id: 9,
    name: 'پیتزا قارچ',
    content: '',
    price: 175000,
    score: 3,
    thumbnail: Assets.images.food4,
    discount: 22,
    tag: FoodTag.special,
  ),
  FoodModel(
    id: 10,
    name: 'ساندویچ کتلت مخصوص',
    content: '',
    price: 205000,
    score: 5,
    thumbnail: Assets.images.food5,
    discount: 50,
    tag: FoodTag.nonPersian,
  ),
  getFood(id: 11, tag: FoodTag.persian),
  getFood(id: 12, tag: FoodTag.persian),
  getFood(id: 13, tag: FoodTag.persian),
  getFood(id: 14, tag: FoodTag.pizza),
  getFood(id: 15, tag: FoodTag.pizza),
  getFood(id: 16, tag: FoodTag.pizza),
  getFood(id: 17, tag: FoodTag.pizza),
  getFood(id: 18, tag: FoodTag.sandwich),
  getFood(id: 19, tag: FoodTag.sandwich),
  getFood(id: 20, tag: FoodTag.sandwich),
];

FoodModel getFood({required int id, required FoodTag tag}) {
  return FoodModel(
    id: id,
    name: 'ساندویچ کتلت مخصوص',
    content: '',
    price: 205000,
    score: 3,
    thumbnail: Assets.images.food5,
    discount: 50,
    tag: tag,
  );
}
