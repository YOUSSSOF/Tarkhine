import 'package:tarkhine/core/core.dart';

String getFoodType(FoodTag tag) {
  switch (tag) {
    case FoodTag.normal:
      return 'عادی';
    case FoodTag.persian:
      return 'ایرانی';
    case FoodTag.nonPersian:
      return 'غیر ایرانی';
    case FoodTag.pizza:
      return 'پیتزا';
    case FoodTag.sandwich:
      return 'ساندویچ';
    case FoodTag.special:
      return 'محصوص';
    default:
      return 'نامعلوم';
  }
}
