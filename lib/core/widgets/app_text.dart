import 'package:flutter/material.dart';

import '../constants/theme/font_manager.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final bool centerText;
  final int maxLines;
  final double fontSize;
  final String? fontFamily;
  final FontWeight fontWeight;
  final bool lineThrough;
  final bool underLine;
  final TextOverflow textOverflow;

  const AppText(
    this.text, {
    this.color,
    this.centerText = false,
    this.maxLines = 1,
    this.fontSize = 12,
    this.fontWeight = FontWeight.normal,
    this.fontFamily,
    this.lineThrough = false,
    this.underLine = false,
    this.textOverflow = TextOverflow.visible,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      text,
      textAlign: centerText ? TextAlign.center : TextAlign.start,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: color ?? Colors.white,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: FontNames.fontName,
            decoration: lineThrough
                ? TextDecoration.lineThrough
                : underLine
                    ? TextDecoration.underline
                    : TextDecoration.none,
            decorationThickness: 1,
            decorationColor: Theme.of(context).primaryColor,
            overflow: TextOverflow.ellipsis,
          ),
    );
  }
}
