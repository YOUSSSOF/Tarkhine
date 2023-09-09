import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarkhine/common/common.dart';
import 'package:tarkhine/core/core.dart';

import '../../data/models/cart_model.dart';

class YxQuantityButton extends StatelessWidget {
  const YxQuantityButton({
    super.key,
    required this.current,
  });

  final CartItemModel current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () =>
              context.cart.increaseQuantity(current, context.auth.user!),
          icon: SvgPicture.asset(Assets.vectors.add),
        ),
        YxText(
          current.quantity.toString().makePersian,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColor.primary,
        ).sizedBox(width: 3),
        IconButton(
          onPressed: () => context.cart.dereaseQuantity(current,context.auth.user!),
          icon: SvgPicture.asset(Assets.vectors.remove),
        ),
      ],
    );
  }
}
