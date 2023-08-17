import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  const AppTheme._();
  static lightTheme(BuildContext context) => Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppColor.primary,
              secondary: AppColor.primary,
            ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  static final darkTheme = ThemeData();
}
