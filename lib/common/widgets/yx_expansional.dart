import 'package:flutter/material.dart';
import 'package:tarkhine/common/common.dart';
import 'package:tarkhine/core/core.dart';

class YxExpansionalHeader extends StatelessWidget {
  const YxExpansionalHeader({
    Key? key,
    required this.text,
    required this.opens,
    required this.index,
  }) : super(key: key);
  final String text;
  final List<bool> opens;
  final int index;
  @override
  Widget build(BuildContext context) {
    return YxText(
      text,
      color: opens[index] ? AppColor.primary : AppColor.black,
    ).marginOnly(right: 20, top: 10);
  }
}

class YxExpansionBody extends StatelessWidget {
  const YxExpansionBody({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return YxText(
      text,
      color: AppColor.black.withOpacity(.6),
      overflow: TextOverflow.visible,
    ).paddingH(20).paddingV(8);
  }
}
