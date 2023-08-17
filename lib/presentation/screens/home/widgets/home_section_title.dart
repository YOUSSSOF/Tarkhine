import 'package:flutter/material.dart';

import '../../../../common/common.dart';
import '../../../../core/core.dart';

class HomeSectionTitle extends StatelessWidget {
  const HomeSectionTitle({
    Key? key,
    required this.text,
    this.isGreenTheme = false,
  }) : super(key: key);
  final String text;
  final bool isGreenTheme;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(9),
        ),
        color: isGreenTheme ? AppColor.white : AppColor.green1,
      ),
      child: YxText(
        text,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
