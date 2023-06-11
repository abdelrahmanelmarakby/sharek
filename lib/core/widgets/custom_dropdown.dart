import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/core/extensions/num.dart';

import '../constants/theme/theme_export.dart';

class AppDropDown extends StatelessWidget {
  const AppDropDown({
    super.key,
    this.icon,
    this.center = false,
    required this.title,
    required this.bottomSheet,
  });
  final Widget? icon;

  final String title;
  final bool center;

  final Widget bottomSheet;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE4E4E5),
        ),
      ),
      width: context.width,
      padding: EdgeInsets.zero,
      child: ListTile(
        onTap: () {
          Get.bottomSheet(
            bottomSheet,
            backgroundColor: Colors.white,
          );
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        dense: true,
        horizontalTitleGap: 10.0,
        minLeadingWidth: 0,
        leading: icon,
        title: Text(
          title,
          style: StylesManager.regular(
            color: ColorsManager.charcoal,
            fontSize: FontSize.medium.h(context),
          ),
        ),
        trailing: icon != null
            ? const Icon(
                Icons.keyboard_arrow_down,
                color: ColorsManager.charcoal,
              )
            : null,
      ),
    );
  }
}
