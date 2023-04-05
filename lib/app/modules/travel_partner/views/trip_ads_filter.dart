import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/extensions/input_formatter.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_dropdown.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/progress_button.dart';
import '../../../../core/widgets/src/radio_button_builder.dart';
import '../../../../core/widgets/src/radio_group.dart';
import '../../../data/models/trip_services_type_model.dart';
import '../controllers/travel_partner_controller.dart';
import '../widgets/trip_services_type_item.dart';

class TripAdsFilter extends GetView<TravelPartnerController> {
  const TripAdsFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TravelPartnerController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('تصفية'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: tripServicesTypes
                        .map(
                          (e) => TripServicesItem(
                            activeIndex: controller.travelPartneFilter,
                            index: e.serviceTypeId ?? 0,
                            title: e.name ?? "",
                            onTap: () {
                              controller.changeTravelPartnerFilterState(
                                e.serviceTypeId ?? 0,
                              );
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  AppDropDown(
                    icon: const Icon(
                      Iconsax.location,
                      color: Colors.black,
                    ),
                    title: "بداية الرحلة",
                    bottomSheet: Container(),
                  ),
                  const SizedBox(height: 12),
                  AppDropDown(
                    icon: const Icon(
                      Iconsax.location_tick,
                      color: Colors.black,
                    ),
                    title: "نهاية الرحلة",
                    bottomSheet: Container(),
                  ),
                  const SizedBox(height: 12),
                  controller.travelPartneFilter == 7
                      ? const CustomTextField(
                          name: "",
                          hint: "نوع السيارة",
                          borderRadius: 8,
                          prefixIcon: Icon(
                            Iconsax.car,
                            color: Colors.black,
                          ),
                        )
                      : const SizedBox(),
                  controller.travelPartneFilter == 7
                      ? const SizedBox(height: 12)
                      : const SizedBox(),
                  CustomTextField(
                    name: "",
                    hint: controller.travelPartneFilter == 6
                        ? "عدد الركاب"
                        : "عدد الركاب المطلوب",
                    borderRadius: 8,
                    prefixIcon: const Icon(
                      Iconsax.people,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    name: "",
                    hint: "تاريخ الرحلة",
                    borderRadius: 8,
                    type: TextInputType.datetime,
                    formattedType: [
                      DateTextFormatter(),
                    ],
                    prefixIcon: const Icon(
                      Iconsax.calendar,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    name: "",
                    hint: "ساعة الرحلة",
                    borderRadius: 8,
                    type: const TextInputType.numberWithOptions(decimal: false),
                    formattedType: [
                      HourMinsFormatter(),
                    ],
                    prefixIcon: const Icon(
                      Iconsax.clock,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const CustomTextField(
                    name: "",
                    hint: "السعر المتوقع",
                    borderRadius: 8,
                    prefixIcon: Icon(
                      Iconsax.moneys,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Expanded(
                        child: AppText(
                          "هل تحتاج طرود؟",
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeights.medium,
                        ),
                      ),
                      Expanded(
                        child: RadioGroup<String>.builder(
                          groupValue: controller.withPackval,
                          onChanged: (value) {},
                          activeColor: ColorsManager.primary,
                          direction: Axis.horizontal,
                          items: controller.withPackstatus,
                          itemBuilder: (item) => RadioButtonBuilder(
                            item,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 27),
                  AppProgressButton(
                    onPressed: (animationController) {},
                    width: context.width,
                    text: "تصفية",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
