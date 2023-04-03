// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/constants/theme/styles_manager.dart';

class TripServicesItem extends StatelessWidget {
  const TripServicesItem({
    Key? key,
    required this.index,
    required this.activeIndex,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final int index;
  final int activeIndex;
  final String title;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.width / 2 - 24,
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 20,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: activeIndex == index
                ? ColorsManager.primary
                : const Color(0xffE4E4E6),
          ),
          borderRadius: BorderRadius.circular(8),
          color: activeIndex == index
              ? ColorsManager.primary
              : const Color(0xffF7F7F7),
        ),
        child: Text(
          title,
          style: StylesManager.regular(
            color: Colors.black,
            fontSize: FontSize.medium,
          ),
        ),
      ),
    );
  }
}
