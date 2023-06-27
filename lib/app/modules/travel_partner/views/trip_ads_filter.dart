import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/app/modules/travel_partner/views/trip_ads_filter_result.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/extensions/input_formatter.dart';
import '../../../../core/global/const.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_dropdown.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/progress_button.dart';
import '../../../../core/widgets/src/radio_button_builder.dart';
import '../../../../core/widgets/src/radio_group.dart';
import '../../../data/models/service_type.dart';
import '../../location_getter_widgets/views/all_cities_widgets.dart';
import '../controllers/travel_partner_controller.dart';
import '../widgets/services_type_item.dart';

class TripAdsFilter extends GetView<TravelPartnerController> {
  const TripAdsFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TravelPartnerController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('تصفية'),
            leading: IconButton(
              icon: Icon(
                Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              ),
              onPressed: () {
                Get.back();
                controller.clearFilterData();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: tripServicesTypes
                        .map(
                          (e) => Container(
                            padding: EdgeInsets.only(
                              left: controller.travelPartneFilter == 6 ? 6 : 0,
                              right: controller.travelPartneFilter == 7 ? 6 : 0,
                            ),
                            width: MediaQuery.of(context).size.width / 2.2,
                            child: ServicesItem(
                              activeIndex: controller.travelPartneFilter,
                              index: e.serviceTypeId ?? 0,
                              title: e.name ?? "",
                              onTap: () {
                                controller.changeTravelPartnerFilterState(
                                  e.serviceTypeId ?? 0,
                                );
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  AppDropDown(
                    title: controller.startCity ?? "بداية الرحلة",
                    center: true,
                    icon: const Icon(
                      Iconsax.location_tick,
                      size: 20,
                      color: Colors.black,
                    ),
                    onTap: () async {
                      String res = await Get.bottomSheet(
                        const AllCitiesWidget(),
                        backgroundColor: Colors.white,
                      );
                      controller.startCity = res;
                      controller.update();
                    },
                  ),
                  const SizedBox(height: 12),
                  AppDropDown(
                    title: controller.endCity ?? "نهاية الرحلة",
                    center: true,
                    icon: const Icon(
                      Iconsax.location_tick,
                      size: 20,
                      color: Colors.black,
                    ),
                    onTap: () async {
                      String res = await Get.bottomSheet(
                        const AllCitiesWidget(),
                        backgroundColor: Colors.white,
                      );
                      controller.endCity = res;
                      controller.update();
                    },
                  ),
                  const SizedBox(height: 12),
                  controller.travelPartneFilter == 7
                      ? CustomTextField(
                          name: "",
                          hint: "نوع السيارة",
                          borderRadius: 8,
                          controller: controller.filterCarTypeCtr,
                          prefixIcon: const Icon(
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
                    controller: controller.filterPassengersCtr,
                    hint: controller.travelPartneFilter == 6
                        ? "عدد الركاب"
                        : "عدد الركاب المطلوب",
                    borderRadius: 8,
                    formattedType: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    type: TextInputType.number,
                    prefixIcon: const Icon(
                      Iconsax.people,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    name: "",
                    hint: controller.filterDate == null
                        ? "تاريخ الرحلة"
                        : appDateFormate(controller.filterDate!, "ar"),
                    borderRadius: 8,
                    readOnly: true,
                    onTap: () {
                      Get.bottomSheet(
                        CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          dateOrder: DatePickerDateOrder.ymd,
                          minimumDate: DateTime.now(),
                          minimumYear: DateTime.now().year,
                          initialDateTime: DateTime.now(),
                          onDateTimeChanged:
                              controller.onDateFilterPickerChanged,
                        ),
                        backgroundColor: Colors.white,
                      );
                    },
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
                    hint: controller.filterTime == null
                        ? "ساعة الرحلة"
                        : appTimeFormate(controller.filterTime!, "ar"),
                    borderRadius: 8,
                    type: const TextInputType.numberWithOptions(decimal: false),
                    formattedType: [
                      HourMinsFormatter(),
                    ],
                    readOnly: true,
                    onTap: () {
                      Get.bottomSheet(
                        CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          initialDateTime: DateTime.now(),
                          onDateTimeChanged:
                              controller.onTimeFilterPickerChanged,
                        ),
                        backgroundColor: Colors.white,
                      );
                    },
                    prefixIcon: const Icon(
                      Iconsax.clock,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    name: "",
                    hint: "السعر المتوقع",
                    controller: controller.filterPriceCtr,
                    borderRadius: 8,
                    type: TextInputType.number,
                    formattedType: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    prefixIcon: const Icon(
                      Iconsax.moneys,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: AppText(
                          controller.travelPartneFilter == 6
                              ? "هل تحتاج الى طرود؟"
                              : "هل تقبل طرود؟",
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeights.medium,
                        ),
                      ),
                      Expanded(
                        child: RadioGroup<String>.builder(
                          groupValue: controller.filterwithPackval,
                          onChanged: controller.changeWithPackFilterStatus,
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
                  const SizedBox(height: 40),
                  AppProgressButton(
                    onPressed: (animationController) {
                      Get.to(
                        () => TripAdsFilterResult(
                          startingPlace: controller.createStartCity ?? "",
                          endingPlace: controller.createEndCity ?? "",
                          servicesTypeid: controller.travelPartneFilter,
                          carType: controller.filterCarTypeCtr.text == ""
                              ? null
                              : controller.filterCarTypeCtr.text,
                          date: controller.filterDate == null
                              ? null
                              : appDateFormate(controller.filterDate!, "en"),
                          time: controller.filterTime == null
                              ? null
                              : appTimeFormate(controller.filterTime!, "en"),
                          numberPassengers: controller
                                      .filterPassengersCtr.text ==
                                  ""
                              ? null
                              : int.parse(controller.filterPassengersCtr.text),
                          price: controller.filterPriceCtr.text == ""
                              ? null
                              : double.parse(controller.filterPriceCtr.text),
                          withPackages: controller.filterIsWithPack,
                        ),
                      );
                    },
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
