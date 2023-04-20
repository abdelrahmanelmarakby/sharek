// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/constants/theme/styles_manager.dart';

class QuantityItemWidget extends StatelessWidget {
  const QuantityItemWidget({
    Key? key,
    required this.index,
    required this.activeIndex,
    required this.title,
    required this.available,
    required this.price,
    required this.onTap,
  }) : super(key: key);
  final int index;
  final int activeIndex;
  final String title;
  final bool available;
  final String price;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: available
                    ? activeIndex == index
                        ? const Color(0xFF27AE60)
                        : const Color(0xffE4E4E6)
                    : const Color(0xFFEB5757),
              ),
              borderRadius: BorderRadius.circular(8),
              color: available
                  ? activeIndex == index
                      ? const Color(0xFF27AE60).withOpacity(.1)
                      : const Color(0xffF7F7F7)
                  : const Color(0xFFEB5757).withOpacity(.1),
            ),
            child: Text(
              "$title ($price)",
              style: StylesManager.medium(
                color: available
                    ? activeIndex == index
                        ? const Color(0xFF27AE60)
                        : Colors.black
                    : const Color(0xFFEB5757),
                fontSize: FontSize.medium,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            available ? "متاح" : "محجوز",
            style: StylesManager.regular(
              color: available
                  ? activeIndex == index
                      ? const Color(0xFF27AE60)
                      : Colors.black
                  : const Color(0xFFEB5757),
              fontSize: FontSize.medium,
            ),
          ),
        ],
      ),
    );
  }
}
