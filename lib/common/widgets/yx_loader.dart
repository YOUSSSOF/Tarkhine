import 'package:flutter/material.dart';
import 'package:tarkhine/common/common.dart';

class YxLoader extends StatelessWidget {
  const YxLoader({
    Key? key,
    this.size,
    this.strokeWidth,
  }) : super(key: key);
  final double? size;
  final double? strokeWidth;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child:  CircularProgressIndicator(
        strokeWidth: strokeWidth??1,
      ),
    ).center;
  }
}
