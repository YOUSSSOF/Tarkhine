import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:tarkhine/common/common.dart';
import 'package:tarkhine/core/core.dart';

import '../../menu/menu_screen.dart';

class CartIsEmpty extends StatelessWidget {
  const CartIsEmpty({
    Key? key,
    required this.title,
    this.height,
    this.width,
    this.menu = true,
  }) : super(key: key);
  final String title;
  final double? height;
  final double? width;
  final bool menu;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            Assets.vectors.spiderweb,
            width: width ?? context.percentWidth(50),
            height: height ?? context.percentWidth(50),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              YxText(title).marginOnly(bottom: 16),
              if (menu)
                YxOutlinedButton(
                  title: 'منوی رستوران',
                  height: 10,
                  width: 30,
                  onPressed: () {
                    context.delivery.fetchMenuItems();
                    context.to(
                      MultiBlocProvider(
                        providers: [
                          BlocProvider.value(value: context.delivery),
                          BlocProvider.value(value: context.cart),
                        ],
                        child: const MenuScreen(
                          title: 'غذای اصلی',
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
