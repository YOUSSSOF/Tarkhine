import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tarkhine/core/constants/assets.dart';

List<BottomNavigationBarItem> bottomNavigationBarItems = [
  BottomNavigationBarItem(
    icon: const Icon(
      Iconsax.user,
      size: 24,
    ),
    label: 'پروفایل',
    activeIcon: SvgPicture.asset(Assets.vectors.userFill),
  ),
  BottomNavigationBarItem(
    icon: const Icon(Iconsax.receipt),
    label: 'سفارشات',
    activeIcon: SvgPicture.asset(Assets.vectors.receiptFill),
  ),
  BottomNavigationBarItem(
    icon: const Icon(
      Iconsax.shopping_cart,
      size: 24,
    ),
    label: 'سبد خرید',
    activeIcon: SvgPicture.asset(Assets.vectors.cartFill),
  ),
  BottomNavigationBarItem(
    icon: const Icon(
      Iconsax.search_normal,
      size: 24,
    ),
    label: 'جست و جو',
    activeIcon: SvgPicture.asset(Assets.vectors.searchFill),
  ),
  BottomNavigationBarItem(
    icon: const Icon(
      Iconsax.home,
      size: 24,
    ),
    label: 'خانه',
    activeIcon: SvgPicture.asset(Assets.vectors.homeFill),
  ),
];
