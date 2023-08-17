import 'package:flutter/material.dart';

import '../../core/constants/enums.dart';
import '../../core/themes/app_colors.dart';
import '../widgets/yx_text.dart';

void showSnackbar(BuildContext context, String message, SnackBarType type) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: YxText(
        message.replaceAll('Exception:', ''),
        color: AppColor.white,
      ),
      backgroundColor: type == SnackBarType.error
          ? AppColor.error
          : type == SnackBarType.success
              ? AppColor.success
              : type == SnackBarType.warning
                  ? AppColor.warning
                  : AppColor.black,
    ),
  );
}
