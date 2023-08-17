import 'package:flutter/material.dart';
import 'package:tarkhine/common/common.dart';

class YxSideBorder extends StatelessWidget {
  const YxSideBorder({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFCBCBCB),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child.paddingV(25).paddingH(25).sizedBox(
            width: context.percentWidth(90),
          ),
    );
  }
}
