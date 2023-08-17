import 'package:flutter/material.dart';
import 'package:tarkhine/presentation/screens/cart/cart_screen.dart';
import 'package:tarkhine/presentation/screens/orders/orders_screen.dart';
import 'package:tarkhine/presentation/screens/profile/profile_screen.dart';
import 'package:tarkhine/presentation/screens/search/search_screen.dart';

import '../../home/home_screen.dart';

List<Widget> screens = [
  const ProfileScreen(),
  const OrdersScreen(),
  const CartScreen(),
  const SearchScreen(),
  const HomeScreen(),
];
