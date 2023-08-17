import 'package:flutter/material.dart';
import 'package:tarkhine/common/common.dart';

import 'menu_body_section.dart';

class MenuBody extends StatelessWidget {
  const MenuBody({
    required this.sections,
    super.key,
  });
  final List<MenuBodySection> sections;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: sections,
      ).marginOnly(bottom: 150),
    );
  }
}
