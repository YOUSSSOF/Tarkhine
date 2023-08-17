import 'package:flutter/material.dart';
import 'package:tarkhine/common/common.dart';

class YxIconText extends StatelessWidget {
  const YxIconText({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        YxText(
          text,
          fontSize: 10,
          color: const Color(0xFF757575),
        ),
        Icon(
          icon,
          color: const Color(0xFF757575),
          size: 12,
        ).marginOnly(left: 5),
      ],
    ).marginOnly(top: 10);
  }
}
