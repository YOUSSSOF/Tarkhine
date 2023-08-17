import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../core/themes/app_colors.dart';

class YxText extends StatelessWidget {
  const YxText(
    this.text, {
    Key? key,
    this.color = AppColor.black,
    this.fontSize = 12,
    this.fontWeight,
    this.lineThrough = false,
    this.overflow,
  }) : super(key: key);
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool lineThrough;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(

        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontFamily: 'Estedad',
        decoration:
            lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
      ),
      textDirection: TextDirection.rtl,
      overflow: overflow?? TextOverflow.ellipsis,
    );
  }
}
