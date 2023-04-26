import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/app/modules/sake_partner/widgets/select_quantity_row.dart';

import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/widgets/app_text.dart';
import '../controllers/sake_partner_controller.dart';

class CreateAdsQuantitySection extends GetView<SakePartnerController> {
  const CreateAdsQuantitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SakePartnerController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            "أختر الكميات",
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeights.semiBold,
          ),
          const SizedBox(height: 12),
          SelectQuantityRow(
            quantity: controller.eighth,
            textEditingController: controller.createEighthPriceCtr,
            increase: controller.icreaseEighth,
            decrease: controller.dereaseEighth,
            title: "الثمن",
          ),
          const SizedBox(height: 12),
          SelectQuantityRow(
            quantity: controller.quarter,
            textEditingController: controller.createQuarterPriceCtr,
            increase: controller.icreaseQuarter,
            decrease: controller.dereaseQuarter,
            title: "الربع",
          ),
          const SizedBox(height: 12),
          SelectQuantityRow(
            quantity: controller.third,
            textEditingController: controller.createThirdPriceCtr,
            increase: controller.icreaseThird,
            decrease: controller.dereaseThird,
            title: "الثلث",
          ),
          const SizedBox(height: 12),
          SelectQuantityRow(
            quantity: controller.half,
            textEditingController: controller.createHalfPriceCtr,
            increase: controller.icreaseHalf,
            decrease: controller.dereaseHalf,
            title: "النصف",
          ),
        ],
      );
    });
  }
}
