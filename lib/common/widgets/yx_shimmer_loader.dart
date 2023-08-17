import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../common.dart';

import '../../core/core.dart';

class YxShimmerLoader extends StatelessWidget {
  const YxShimmerLoader({
    Key? key,
    required this.height,
    this.width,
    this.radius,
  }) : super(key: key);
  final double height;
  final double? width;
  final BorderRadius? radius;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColor.black.withOpacity(.2),
        highlightColor: AppColor.black.withOpacity(.4),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: radius,
            color: AppColor.black.withOpacity(.3),
          ),
        )).sizedBox(height: height, width: width);
  }
}
