import 'package:flutter/material.dart';

class AppColors {
  static Color dangerColor = Colors.red;
  static Color successColor = Colors.green;
  static Color warningColor = Colors.redAccent;
  static const Color primaryColor = Color(0xff714B67);
  static Color primaryColorPale = Colors.grey;
  static Color majorColorPale = Colors.black.withOpacity(0.5);
  static const Color infoColor = Color(0xFF02CAF2);
}

extension ColorExtension on Color {
  WidgetStateProperty<Color> get materialColor {
    return WidgetStateProperty.all<Color>(this);
  }
}
