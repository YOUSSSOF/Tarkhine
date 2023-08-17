import 'package:flutter/material.dart';

import 'package:tarkhine/common/common.dart';
import 'package:tarkhine/core/core.dart';

class YxAppbar extends StatelessWidget implements PreferredSize {
  const YxAppbar({
    Key? key,
    required this.title,
    this.back = true,
  }) : super(key: key);

  final String title;
  final bool back;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: 60,
      centerTitle: true,
      title: YxText(
        title,
        color: AppColor.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      actions: back == false
          ? null
          : [
              IconButton(
                onPressed: context.back,
                icon: const Icon(
                  Icons.arrow_forward,
                  size: 25,
                ),
              ),
            ],
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
