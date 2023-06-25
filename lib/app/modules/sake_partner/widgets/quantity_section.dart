// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/app/modules/sake_partner/widgets/quantity_item_widget.dart';
import 'package:sharek/core/widgets/progress_button.dart';

import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../data/models/sarifice_ad_item_model.dart';
import '../controllers/sake_partner_controller.dart';

class SakeQuantitySection extends GetView<SakePartnerController> {
  const SakeQuantitySection({
    Key? key,
    required this.quantities,
    required this.id,
  }) : super(key: key);
  final Quantities? quantities;
  final int id;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          "الكميات",
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeights.semiBold,
        ),
        const SizedBox(height: 12),
        Wrap(
          runSpacing: 4,
          spacing: 4,
          children: [
            if (quantities?.quarter?.quantity == 0 &&
                quantities?.quarter?.price != 0)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                child: QuantityItemWidget(
                  activeIndex: controller.sacrificeReservationId ?? -1,
                  index: 0,
                  title: "ربع",
                  onTap: () {
                    quantities?.quarter?.quantity != 0
                        ? controller.changesacrificeReservationState(
                            "quarter", 0)
                        : null;
                  },
                  available: quantities?.quarter?.quantity != 0 ? true : false,
                  price: quantities?.quarter?.price.toString() ?? "",
                ),
              ),
            for (int i = 0; i < (quantities?.quarter?.quantity ?? 0); i++)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                child: QuantityItemWidget(
                  activeIndex: controller.sacrificeReservationId ?? -1,
                  index: 0,
                  title: "ربع",
                  onTap: () {
                    quantities?.quarter?.quantity != 0
                        ? controller.changesacrificeReservationState(
                            "quarter", 0)
                        : null;
                  },
                  available: quantities?.quarter?.quantity != 0 ? true : false,
                  price: quantities?.quarter?.price.toString() ?? "",
                ),
              ),
            if (quantities?.half?.quantity == 0 && quantities?.half?.price != 0)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                child: QuantityItemWidget(
                  activeIndex: controller.sacrificeReservationId ?? -1,
                  index: 1,
                  title: "نصف",
                  onTap: () {
                    quantities?.half?.quantity != 0
                        ? controller.changesacrificeReservationState("half", 1)
                        : null;
                  },
                  available: quantities?.half?.quantity != 0 ? true : false,
                  price: quantities?.half?.price.toString() ?? "",
                ),
              ),
            for (int i = 0; i < (quantities?.half?.quantity ?? 0); i++)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                child: QuantityItemWidget(
                  activeIndex: controller.sacrificeReservationId ?? -1,
                  index: 1,
                  title: "نصف",
                  onTap: () {
                    quantities?.half?.quantity != 0
                        ? controller.changesacrificeReservationState("half", 1)
                        : null;
                  },
                  available: quantities?.half?.quantity != 0 ? true : false,
                  price: quantities?.half?.price.toString() ?? "",
                ),
              ),
            if (quantities?.third?.quantity == 0 &&
                quantities?.third?.price != 0)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                child: QuantityItemWidget(
                  activeIndex: controller.sacrificeReservationId ?? -1,
                  index: 2,
                  title: "ثلث",
                  onTap: () {
                    quantities?.third?.quantity != 0
                        ? controller.changesacrificeReservationState("third", 0)
                        : null;
                  },
                  available: quantities?.third?.quantity != 0 ? true : false,
                  price: quantities?.third?.price.toString() ?? "",
                ),
              ),
            for (int i = 0; i < (quantities?.third?.quantity ?? 0); i++)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                child: QuantityItemWidget(
                  activeIndex: controller.sacrificeReservationId ?? -1,
                  index: 2,
                  title: "ثلث",
                  onTap: () {
                    quantities?.third?.quantity != 0
                        ? controller.changesacrificeReservationState("third", 2)
                        : null;
                  },
                  available: quantities?.third?.quantity != 0 ? true : false,
                  price: quantities?.third?.price.toString() ?? "",
                ),
              ),
            if (quantities?.eighth?.quantity == 0 &&
                quantities?.eighth?.price != 0)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                child: QuantityItemWidget(
                  activeIndex: controller.sacrificeReservationId ?? -1,
                  index: 3,
                  title: "ثمن",
                  onTap: () {
                    quantities?.eighth?.quantity != 0
                        ? controller.changesacrificeReservationState(
                            "eighth",
                            3,
                          )
                        : null;
                  },
                  available: quantities?.eighth?.quantity != 0 ? true : false,
                  price: quantities?.eighth?.price.toString() ?? "",
                ),
              ),
            for (int i = 0; i < (quantities?.eighth?.quantity ?? 0); i++)
              if (quantities?.eighth?.price != 0)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  child: QuantityItemWidget(
                    activeIndex: controller.sacrificeReservationId ?? -1,
                    index: 3,
                    title: "ثمن",
                    onTap: () {
                      quantities?.eighth?.quantity != 0
                          ? controller.changesacrificeReservationState(
                              "eighth",
                              3,
                            )
                          : null;
                    },
                    available: quantities?.eighth?.quantity != 0 ? true : false,
                    price: quantities?.eighth?.price.toString() ?? "",
                  ),
                ),
          ],
        ),
        const SizedBox(height: 24),
        Center(
          child: AppProgressButton(
            width: context.width,
            text: "حجز",
            onPressed: (anim) {
              if (controller.sacrificeReservation != null ||
                  controller.sacrificeReservationId != null) {
                controller.createSacrificeReservation(
                  animationController: anim,
                  id: id,
                  quantity: controller.sacrificeReservation ?? "",
                );
              } else {
                BotToast.showText(text: "يجب اختيار الكمية المطلوبة قبل الحجز");
              }
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
