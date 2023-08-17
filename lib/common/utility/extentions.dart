import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarkhine/common/common.dart';
import 'package:tarkhine/data/models/food_model.dart';
import 'package:tarkhine/logic/cubits/cart_cubit.dart';
import 'package:tarkhine/logic/cubits/delivery_cubit.dart';
import 'package:tarkhine/logic/cubits/order_cubit.dart';
import 'package:tarkhine/logic/cubits/search_cubit.dart';
import '../../logic/cubits/authentication_cubit.dart';
import '../../logic/cubits/navigation_cubit.dart';

extension ObjectUtils on Object? {
  bool get nullOrNot => this == null;
}

extension Persian on String {
  String get makePersian => makePricePersian(this);
}

extension BlocsContex on BuildContext {
  AuthenticationCubit get auth => read<AuthenticationCubit>();
  NavigationCubit get nav => read<NavigationCubit>();
  DeliveryCubit get delivery => read<DeliveryCubit>();
  CartCubit get cart => read<CartCubit>();
  SearchCubit get search => read<SearchCubit>();
  OrderCubit get order => read<OrderCubit>();

  AuthenticationCubit get authWatch => watch<AuthenticationCubit>();
  NavigationCubit get navWatch => watch<NavigationCubit>();
  DeliveryCubit get deliveryWatch => watch<DeliveryCubit>();
  CartCubit get cartWatch => watch<CartCubit>();
  SearchCubit get searchWatch => watch<SearchCubit>();
  OrderCubit get orderWatch => watch<OrderCubit>();

}

extension DeliveryUtils on List<FoodModel>? {
  List<FoodModel>? filterWithTag(tag) {
    if (this != null) {
      return this!.where((food) => food.tag == tag).toList();
    }
    return null;
  }
}

extension ContextRouterExtention on BuildContext {
  void to(Widget child) => Navigator.of(this).push(
        MaterialPageRoute(builder: (_) => child),
      );
  void toOff(Widget child) => Navigator.of(this).pushReplacement(
        MaterialPageRoute(builder: (_) => child),
      );
  void toOffAll(Widget child) => Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => child),
      (Route<dynamic> route) => false);
  void toFirst() => Navigator.of(this).popUntil((route) => route.isFirst);
  void toNamed(String path) => Navigator.of(this).pushNamed(path);
  void back() => Navigator.pop(this);
}

extension ContextDimensionsExtentions on BuildContext {
  get width => MediaQuery.of(this).size.width;
  get height => MediaQuery.of(this).size.height;
  double percentWidth(double percent) =>
      (MediaQuery.of(this).size.width / 100) * percent;
  double percentHeight(double percent) =>
      (MediaQuery.of(this).size.height / 100) * percent;
  double percentWidthLimited(int percent, int max) =>
      (MediaQuery.of(this).size.width / 100) * percent > max
          ? max.toDouble()
          : (MediaQuery.of(this).size.width / 100) * percent;
  double percentHeightLimited(int percent, int max) =>
      (MediaQuery.of(this).size.height / 100) * percent > max
          ? max.toDouble()
          : (MediaQuery.of(this).size.height / 100) * percent;
}

extension WidgetUtilsExtentions on Widget {
  Widget get vMargin3 =>
      Container(margin: const EdgeInsets.symmetric(vertical: 3), child: this);
  Widget get vMargin6 =>
      Container(margin: const EdgeInsets.symmetric(vertical: 6), child: this);
  Widget get vMargin9 =>
      Container(margin: const EdgeInsets.symmetric(vertical: 9), child: this);
  Widget get hMargin3 =>
      Container(margin: const EdgeInsets.symmetric(horizontal: 3), child: this);
  Widget get hMargin6 =>
      Container(margin: const EdgeInsets.symmetric(horizontal: 6), child: this);
  Widget get hMargin9 =>
      Container(margin: const EdgeInsets.symmetric(horizontal: 9), child: this);
  Widget get margin3 => Container(margin: const EdgeInsets.all(3), child: this);
  Widget get margin6 => Container(margin: const EdgeInsets.all(6), child: this);
  Widget get margin9 => Container(margin: const EdgeInsets.all(9), child: this);

  Widget get vPadding3 =>
      Container(padding: const EdgeInsets.symmetric(vertical: 3), child: this);
  Widget get vPadding6 =>
      Container(padding: const EdgeInsets.symmetric(vertical: 6), child: this);
  Widget get vPadding9 =>
      Container(padding: const EdgeInsets.symmetric(vertical: 9), child: this);
  Widget get hPadding3 => Container(
      padding: const EdgeInsets.symmetric(horizontal: 3), child: this);
  Widget get hPadding6 => Container(
      padding: const EdgeInsets.symmetric(horizontal: 6), child: this);
  Widget get hPadding9 => Container(
      padding: const EdgeInsets.symmetric(horizontal: 9), child: this);
  Widget get padding3 =>
      Container(padding: const EdgeInsets.all(3), child: this);
  Widget get padding6 =>
      Container(padding: const EdgeInsets.all(6), child: this);
  Widget get padding9 =>
      Container(padding: const EdgeInsets.all(9), child: this);
  Widget padding(double padding) =>
      Container(padding: EdgeInsets.all(padding), child: this);
  Widget paddingH(double padding) => Container(
      padding: EdgeInsets.symmetric(horizontal: padding), child: this);
  Widget paddingV(double padding) =>
      Container(padding: EdgeInsets.symmetric(vertical: padding), child: this);
  Widget margin(double margin) =>
      Container(margin: EdgeInsets.all(margin), child: this);
  Widget marginH(double margin) =>
      Container(padding: EdgeInsets.symmetric(horizontal: margin), child: this);
  Widget marginV(double margin) =>
      Container(padding: EdgeInsets.symmetric(vertical: margin), child: this);

  Widget marginOnly({
    double top = 0,
    double bottom = 0,
    double left = 0,
    double right = 0,
  }) =>
      Container(
        margin: EdgeInsets.only(
          top: top,
          bottom: bottom,
          left: left,
          right: right,
        ),
        child: this,
      );
  Widget paddingOnly({
    double top = 0,
    double bottom = 0,
    double left = 0,
    double right = 0,
  }) =>
      Container(
        padding: EdgeInsets.only(
          top: top,
          bottom: bottom,
          left: left,
          right: right,
        ),
        child: this,
      );
  Widget sizedBox({double? height, double? width}) =>
      SizedBox(height: height, width: width, child: this);

  Widget get card => Card(child: this);
  Widget get expand => Expanded(child: this);
  Widget get center => Center(child: this);
}
