import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class YxStar extends StatelessWidget {
  const YxStar(
    this.rate, {
    Key? key,
    this.size,
  }) : super(key: key);
  final int rate;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/vectors/Rate=$rate.svg',
      height: size,
      width: size,
    );
  }
}
