import 'package:flutter/material.dart';

import 'package:tarkhine/common/common.dart';

import '../../core/core.dart';

class YxOutlinedButton extends StatelessWidget {
  const YxOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.fontSize,
    this.fontWeight,
    this.height,
    this.width,
    this.color,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;
  final double? width;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          width: 1,
          color: color ?? AppColor.primary,
        ),
      ),
      onPressed: onPressed,
      child: YxText(
        title,
        fontWeight: fontWeight ?? FontWeight.w300,
        fontSize: fontSize ?? 10,
        color: color ?? AppColor.primary,
      ).paddingV(height ?? 0).paddingH(width ?? 0),
    );
  }
}
