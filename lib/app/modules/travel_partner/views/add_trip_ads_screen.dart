// ignore_for_file: unused_local_variable

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/theme/app_icons.dart';
import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/extensions/input_formatter.dart';
import '../../../../core/widgets/app_expansion_tile.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/progress_button.dart';
import '../../../../core/widgets/src/radio_button_builder.dart';
import '../../../../core/widgets/src/radio_group.dart';
import '../../../data/models/trip_services_type_model.dart';
import '../controllers/travel_partner_controller.dart';
import '../widgets/trip_services_type_item.dart';

class AddTripAdsScreen extends GetView<TravelPartnerController> {
  const AddTripAdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TravelPartnerController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('إضافة إعلان'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    "أختر نوع الخدمة",
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeights.semiBold,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: tripServicesTypes
                        .map(
                          (e) => TripServicesItem(
                            activeIndex: controller.addTravelPartner,
                            index: e.serviceTypeId ?? 0,
                            title: e.name ?? "",
                            onTap: () {
                              controller.changeAddTravelPartnerState(
                                e.serviceTypeId ?? 0,
                              );
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  const AppExpansionTile(
                    icon: Iconsax.location,
                    title: "بداية الرحلة",
                  ),
                  const SizedBox(height: 12),
                  const AppExpansionTile(
                    icon: Iconsax.location_tick,
                    title: "نهاية الرحلة",
                  ),
                  const SizedBox(height: 12),
                  controller.addTravelPartner == 7
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
                  controller.addTravelPartner == 7
                      ? const SizedBox(height: 12)
                      : const SizedBox(),
                  CustomTextField(
                    name: "",
                    hint: controller.addTravelPartner == 6
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
                          groupValue: controller.status.first,
                          onChanged: (value) {},
                          activeColor: ColorsManager.primary,
                          direction: Axis.horizontal,
                          items: controller.status,
                          itemBuilder: (item) => RadioButtonBuilder(
                            item,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  DottedBorder(
                    color: const Color(0xFFE4E4E5),
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF7F7F9),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            SharekIcons.upload_1,
                            color: ColorsManager.primary,
                          ),
                          SizedBox(width: 10),
                          AppText(
                            "رفع الصور أو الملفات",
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeights.light,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const CustomTextField(
                    name: "",
                    hint: "رقم الجوال الظاهر في الإعلان (إختياري)",
                    borderRadius: 8,
                    prefixIcon: Icon(
                      Iconsax.call,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 27),
                  AppProgressButton(
                    onPressed: (animationController) {},
                    width: context.width,
                    text: "إضافة إعلان جديد",
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
