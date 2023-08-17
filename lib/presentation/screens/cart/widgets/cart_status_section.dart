import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarkhine/common/common.dart';

import '../../../../core/core.dart';

class CartStatusSection extends StatelessWidget {
  const CartStatusSection({
    super.key,
    required this.status,
  });
  final CartStatus status;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      status == CartStatus.cart
          ? Assets.vectors.cart
          : status == CartStatus.completeInfo
              ? Assets.vectors.completeInfo
              : Assets.vectors.checkout,
      height: 50,
      width: context.percentWidth(90),
    ).marginH(20);
  }
}
