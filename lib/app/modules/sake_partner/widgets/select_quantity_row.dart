// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/core/extensions/validator.dart';

import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_text_field.dart';

class SelectQuantityRow extends StatelessWidget {
  const SelectQuantityRow({
    Key? key,
    required this.title,
    required this.textEditingController,
    required this.quantity,
    this.increase,
    this.decrease,
  }) : super(key: key);
  final String title;

  final TextEditingController textEditingController;
  final int quantity;
  final Function()? increase;
  final Function()? decrease;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 65,
          child: CustomTextField(
            hint: "(ادخل السعر)",
            controller: textEditingController,
            type: TextInputType.number,
            validate: Validator.validateEmpty,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Iconsax.moneys,
                  ),
                  const SizedBox(width: 12),
                  AppText(
                    title,
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeights.medium,
                  ),
                ],
              ),
            ),
          ),
        ),
        const Spacer(flex: 5),
        Expanded(
          flex: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: increase,
                icon: Container(
                  height: 24,
                  width: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF1DA1F3),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
              AppText(
                quantity.toString(),
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeights.semiBold,
              ),
              IconButton(
                onPressed: decrease,
                icon: Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFF7F7F9),
                    border: Border.all(
                      color: const Color(0xFFE4E4E5),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.remove,
                    color: Color(0xFF7D848D),
                    size: 12,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
