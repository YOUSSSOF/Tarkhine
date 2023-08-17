import 'package:flutter/material.dart';
import 'package:tarkhine/common/common.dart';

import '../../core/themes/app_colors.dart';

class YxButton extends StatelessWidget {
  const YxButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.color,
    this.child,
    this.paddingV = 0,
    this.paddingH = 0,
    this.fontSize = 10,
    this.fontWeight,
    this.height,
    this.width,
  }) : super(key: key);
  final String? title;
  final VoidCallback? onPressed;
  final Color? color;
  final Widget? child;
  final double paddingV;
  final double paddingH;
  final double? fontSize;
  final double? height;
  final double? width;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: color,
      ),
      onPressed: onPressed,
      child: child ??
          YxText(
            title!,
            fontWeight: fontWeight ?? FontWeight.w300,
            fontSize: fontSize,
            color: AppColor.white,
          )
              .center
              .sizedBox(
                height: height,
                width: width,
              )
              .paddingV(paddingV)
              .paddingH(paddingH),
    );
  }
}
