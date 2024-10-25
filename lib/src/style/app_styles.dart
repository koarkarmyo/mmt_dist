import 'package:flutter/material.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';

import 'app_color.dart';

class AppStyles {
  static ButtonStyle buttonStyle = ButtonStyle(
      padding: MaterialStatePropertyAll(24.horizontalPadding),
      foregroundColor: const MaterialStatePropertyAll(Colors.white),
      backgroundColor: MaterialStatePropertyAll(AppColors.primaryColor));

  static ButtonStyle warningButtonStyle = ButtonStyle(
      padding: MaterialStatePropertyAll(24.horizontalPadding),
      foregroundColor: const MaterialStatePropertyAll(Colors.white),
      backgroundColor: MaterialStatePropertyAll(AppColors.warningColor));

  //
  static ButtonStyle confirmButtonStyle = ButtonStyle(
      padding: MaterialStatePropertyAll(24.horizontalPadding),
      foregroundColor: const MaterialStatePropertyAll(Colors.white),
      backgroundColor: MaterialStatePropertyAll(AppColors.successColor));
}
