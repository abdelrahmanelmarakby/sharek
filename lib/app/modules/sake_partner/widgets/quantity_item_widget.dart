// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/constants/theme/styles_manager.dart';

class QuantityItemWidget extends StatefulWidget {
  const QuantityItemWidget({
    Key? key,
    required this.index,
    required this.activeIndex,
    required this.title,
    required this.available,
    required this.price,
    this.onTap,
  }) : super(key: key);
  final int index;
  final int activeIndex;
  final String title;
  final bool available;
  final String price;
  final Function()? onTap;

  @override
  State<QuantityItemWidget> createState() => _QuantityItemWidgetState();
}

class _QuantityItemWidgetState extends State<QuantityItemWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap!();
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: context.width / 5,
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: widget.available
                    ? (widget.activeIndex == widget.index) && isSelected
                        ? const Color(0xFF27AE60)
                        : const Color(0xffE4E4E6)
                    : const Color(0xFFEB5757),
              ),
              borderRadius: BorderRadius.circular(8),
              color: widget.available
                  ? (widget.activeIndex == widget.index) && isSelected
                      ? const Color(0xFF27AE60).withOpacity(.1)
                      : const Color(0xffF7F7F7)
                  : const Color(0xFFEB5757).withOpacity(.1),
            ),
            child: Text(
              "${widget.title} (${widget.price})",
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              style: StylesManager.medium(
                color: widget.available
                    ? (widget.activeIndex == widget.index) && isSelected
                        ? const Color(0xFF27AE60)
                        : Colors.black
                    : const Color(0xFFEB5757),
                fontSize: FontSize.medium,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.available ? "متاح" : "محجوز",
            style: StylesManager.regular(
              color: widget.available
                  ? (widget.activeIndex == widget.index) && isSelected
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
