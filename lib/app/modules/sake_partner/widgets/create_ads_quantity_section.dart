import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/core/widgets/custom_text_field.dart';

import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/widgets/app_text.dart';
import '../controllers/sake_partner_controller.dart';

class CreateAdsQuantitySection extends GetView<SakePartnerController> {
  const CreateAdsQuantitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppText(
          "أختر الكميات",
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeights.semiBold,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              flex: 60,
              child: CustomTextField(
                hint: "(ادخل السعر)",
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Iconsax.moneys,
                      ),
                      SizedBox(width: 12),
                      AppText(
                        "الثمن",
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeights.medium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 40,
              child: Row(
                children: const [],
              ),
            )
          ],
        )
      ],
    );
  }
}
