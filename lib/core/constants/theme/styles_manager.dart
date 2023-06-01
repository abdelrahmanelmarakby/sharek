import 'package:flutter/widgets.dart';
import 'package:sharek/core/constants/theme/theme_export.dart';

//TextStyle builder method
TextStyle _getTextStyle({
  double? fontSize,
  String? fontFamily,
  Color? color,
  FontWeight? fontWeight,
  TextOverflow? overFlow = TextOverflow.ellipsis,
  TextDecoration decoration = TextDecoration.none,
}) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      decoration: decoration,
      fontWeight: fontWeight,
      overflow: overFlow);
}

class StylesManager {
  ///regular TextStyle
  static TextStyle regular(
      {double fontSize = 10,
      Color? color,
      TextDecoration decoration = TextDecoration.none}) {
    return _getTextStyle(
        fontSize: fontSize,
        fontFamily: FontNames.fontName,
        color: color,
        decoration: decoration,
        fontWeight: FontWeights.regular);
  }

// Bold TextStyle
  static TextStyle bold(
      {double fontSize = 10,
      Color? color,
      TextDecoration decoration = TextDecoration.none}) {
    return _getTextStyle(
        fontSize: fontSize,
        fontFamily: FontNames.fontName,
        decoration: decoration,
        color: color,
        fontWeight: FontWeights.bold);
  }

// Medium TextStyle
  static TextStyle medium(
      {double fontSize = 10,
      Color? color,
      TextDecoration decoration = TextDecoration.none}) {
    return _getTextStyle(
        fontSize: fontSize,
        fontFamily: FontNames.fontName,
        decoration: decoration,
        color: color,
        fontWeight: FontWeights.regular);
  }

// Light TextStyle
  static TextStyle light(
      {double fontSize = 10,
      Color? color,
      TextDecoration decoration = TextDecoration.none}) {
    return _getTextStyle(
        fontSize: fontSize,
        fontFamily: FontNames.fontName,
        decoration: decoration,
        overFlow: TextOverflow.visible,
        color: color,
        fontWeight: FontWeights.light);
  }

// SemiBold TextStyle
  static TextStyle semiBold({
    double fontSize = 10,
    Color? color,
    TextDecoration decoration = TextDecoration.none,
  }) {
    return _getTextStyle(
        fontSize: fontSize,
        fontFamily: FontNames.fontName,
        decoration: decoration,
        color: color,
        fontWeight: FontWeights.semiBold);
  }

// ExtraBold TextStyle
  static TextStyle extraBold(
      {double fontSize = 10,
      Color? color,
      TextDecoration decoration = TextDecoration.none}) {
    return _getTextStyle(
        fontSize: fontSize,
        fontFamily: FontNames.fontName,
        decoration: decoration,
        color: color,
        fontWeight: FontWeights.extraBold);
  }

// Black TextStyle
  static TextStyle black(
      {double fontSize = 10,
      Color? color,
      TextDecoration decoration = TextDecoration.none}) {
    return _getTextStyle(
        fontSize: fontSize,
        decoration: decoration,
        fontFamily: FontNames.fontName,
        color: color,
        fontWeight: FontWeights.black);
  }

// Thin TextStyle
  static TextStyle thin(
      {double fontSize = 10,
      Color? color,
      TextDecoration decoration = TextDecoration.none}) {
    return _getTextStyle(
        fontSize: fontSize,
        decoration: decoration,
        fontFamily: FontNames.fontName,
        color: color,
        fontWeight: FontWeights.extraBold);
  }
}
