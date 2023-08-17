import 'package:flutter/material.dart';
import 'package:tarkhine/common/common.dart';


class YxSeprator extends StatelessWidget {
  const YxSeprator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFCBCBCB),
      height: 1.3,
    ).marginH(2).marginV(12);
  }
}
