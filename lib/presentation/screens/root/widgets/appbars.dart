import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tarkhine/common/widgets/yx_appbar.dart';

import '../../../../common/utility/extentions.dart';
import '../../../../common/widgets/yx_text.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/themes/app_colors.dart';

List appbars = [
  null,
  const YxAppbar(
    title: 'سفارشات',
    back: false,
  ),
  const YxAppbar(
    title: 'سبد خرید',
    back: false,
  ),
  const YxAppbar(
    title: 'جست و جو',
    back: false,
  ),
  AppBar(
    elevation: 0,
    toolbarHeight: 60,
    actions: [
      SvgPicture.asset(
        Assets.vectors.splashLogo,
        height: 30,
        width: 100,
      ).marginH(20),
    ],
    leadingWidth: 90,
    leading: Container(
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 15),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.3),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          const Icon(Iconsax.arrow_down, size: 12),
          const YxText('شعبه', color: AppColor.white).marginH(4),
          const Icon(Iconsax.location, size: 12),
        ],
      ),
    ),
  ),
];
