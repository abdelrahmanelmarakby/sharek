import 'package:flutter/material.dart';
import 'package:sharek/core/extensions/export.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/theme/colors_manager.dart';

class CustomShimmer extends StatelessWidget {
  final Widget? child;

  final Color? color;

  final bool useLightDark;

  const CustomShimmer({
    Key? key,
    this.child,
    this.color,
    this.useLightDark = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: color == null
          ? context.isDarkMode
              ? ColorsManager.darkGrey
              : ColorsManager.lightGrey
          : color!,
      highlightColor:
          context.isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
      child: child!,
    );
  }
}
