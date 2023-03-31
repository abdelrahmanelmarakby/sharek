import 'package:flutter/material.dart';

import '../constants/theme/theme_export.dart';

extension SuiizColors on Color {
  /// Returns a [MaterialColor] from a [Color] object
  MaterialColor getMaterialColorFromColor() {
    final colorShades = <int, Color>{
      50: ColorsManager.getShade(this, value: 0.5),
      100: ColorsManager.getShade(this, value: 0.4),
      200: ColorsManager.getShade(this, value: 0.3),
      300: ColorsManager.getShade(this, value: 0.2),
      400: ColorsManager.getShade(this, value: 0.1),
      500: this, //Primary value
      600: ColorsManager.getShade(this, value: 0.1, darker: true),
      700: ColorsManager.getShade(this, value: 0.15, darker: true),
      800: ColorsManager.getShade(this, value: 0.2, darker: true),
      900: ColorsManager.getShade(this, value: 0.25, darker: true),
    };
    return MaterialColor(value, colorShades);
  }
}
