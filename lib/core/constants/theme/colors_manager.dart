import 'package:flutter/material.dart';

class ColorsManager {
  static const Color primary = Color(0xFF1DA1F3);
  static const Color selection = Color(0xFF3E6FCF);
  static const Color accent = Color(0xFFF08A31);
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF3F3F3);
  static const Color veryLightGrey = Color(0xFFCDCDCD);
  static const Color checkBoxBorderColor = Color(0xFFD9D9D9);
  static const Color lightGrey = Color(0xFF9E9E9E);
  static const Color grey = Color(0xFF8C8C8C); //#8C8C8C
  static const Color darkGrey = Color(0xFF7F7F7F);
  static const Color veryDarkGrey = Color(0xFF505050);
  static const Color charcoal = Color(0xFF222222);
  static const Color black = Color(0xFF000000);
  static const Color error = Color(0xFFB00020);
  static const Color red = Color(0xFFFA5F5F);
  static const Color success = Color(0xFF00C853);
  static const Color red2 = Color(0xFFFF0000);

  static MaterialStateProperty<Color?> greyMatrialColor =
      MaterialStateColor.resolveWith((states) {
    if (states.contains(MaterialState.disabled)) {
      return white; // Use a lighter shade of grey when disabled
    }
    return white; // Use a darker shade of grey for other states
  });

  static Color getShade(Color color, {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1, 'shade values must be between 0 and 1');

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness(
      (darker ? (hsl.lightness - value) : (hsl.lightness + value))
          .clamp(0.0, 1.0),
    );

    return hslDark.toColor();
  }
}
