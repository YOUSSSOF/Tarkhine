import 'package:flutter/material.dart';
import 'package:tarkhine/common/common.dart';
import 'package:tarkhine/core/core.dart';

class YxChip extends StatelessWidget {
  const YxChip({
    required this.title,
    this.onTap,
    super.key,
  });
  final String title;
  final Function(String)? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(title),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: .2,
            color: AppColor.black.withOpacity(.2),
          ),
        ),
        child: YxText(title).vMargin3.hPadding6,
      ).marginOnly(right: 8),
    );
  }
}
