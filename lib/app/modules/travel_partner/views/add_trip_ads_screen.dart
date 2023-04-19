// ignore_for_file: unused_local_variable

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/core/extensions/validator.dart';

import '../../../../core/constants/theme/app_icons.dart';
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
import '../../../data/models/trip_services_type_model.dart';
import '../controllers/travel_partner_controller.dart';
import '../widgets/services_type_item.dart';

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
              child: Form(
                key: controller.createTripAdsFormKey,
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
                            (e) => Container(
                              padding: EdgeInsets.only(
                                left: controller.addTravelPartner == 6 ? 6 : 0,
                                right: controller.addTravelPartner == 7 ? 6 : 0,
                              ),
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: ServicesItem(
                                activeIndex: controller.addTravelPartner,
                                index: e.serviceTypeId ?? 0,
                                title: e.name ?? "",
                                onTap: () {
                                  controller.changeAddTravelPartnerState(
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
                      icon: const Icon(
                        Iconsax.location,
                        size: 20,
                        color: Colors.black,
                      ),
                      title: "بداية الرحلة",
                      bottomSheet: Container(),
                    ),
                    const SizedBox(height: 12),
                    AppDropDown(
                      icon: const Icon(
                        Iconsax.location_tick,
                        size: 20,
                        color: Colors.black,
                      ),
                      title: "نهاية الرحلة",
                      bottomSheet: Container(),
                    ),
                    const SizedBox(height: 12),
                    controller.addTravelPartner == 7
                        ? CustomTextField(
                            name: "",
                            hint: "نوع السيارة",
                            borderRadius: 8,
                            type: TextInputType.text,
                            validate: Validator.validateEmpty,
                            controller: controller.createTripAdsCarTypeCtr,
                            prefixIcon: const Icon(
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
                      validate: Validator.validateEmpty,
                      controller: controller.createTripAdsNumberPassengersCtr,
                      hint: controller.addTravelPartner == 6
                          ? "عدد الركاب"
                          : "عدد الركاب المطلوب",
                      borderRadius: 8,
                      type: TextInputType.number,
                      prefixIcon: const Icon(
                        Iconsax.people,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      name: "",
                      hint: controller.createAdsDate == null
                          ? "تاريخ الرحلة"
                          : appDateFormate(controller.createAdsDate!, "ar"),
                      borderRadius: 8,
                      readOnly: true,
                      onTap: () {
                        Get.bottomSheet(
                          CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            dateOrder: DatePickerDateOrder.ymd,
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged:
                                controller.onDateCreatePickerChanged,
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
                      hint: controller.createAdsTime == null
                          ? "ساعة الرحلة"
                          : appTimeFormate(controller.createAdsTime!, "ar"),
                      borderRadius: 8,
                      type:
                          const TextInputType.numberWithOptions(decimal: false),
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
                                controller.onTimeCreatePickerChanged,
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
                      borderRadius: 8,
                      controller: controller.createTripAdsPriceCtr,
                      validate: Validator.validateEmpty,
                      type: TextInputType.number,
                      prefixIcon: const Icon(
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
                            onChanged: controller.changeWithPackstatus,
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
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        controller.pickCreateTripAdsImages();
                      },
                      child: DottedBorder(
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
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      name: "",
                      hint: "رقم الجوال الظاهر في الإعلان (إختياري)",
                      borderRadius: 8,
                      type: TextInputType.phone,
                      controller: controller.createTripAdPhoneCtr,
                      prefixIcon: const Icon(
                        Iconsax.call,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 27),
                    Center(
                      child: AppProgressButton(
                        width: context.width,
                        text: "إضافة إعلان جديد",
                        onPressed: (animationController) {
                          if (controller.createTripAdsFormKey.currentState!
                                  .validate() &&
                              controller.createAdsDate != null &&
                              controller.createAdsTime != null) {
                            controller.createTripAds(
                              animationController: animationController,
                              servicesTypeid: controller.addTravelPartner,
                              startingPlace: "sssss",
                              numberPassengers: int.parse(
                                controller
                                    .createTripAdsNumberPassengersCtr.text,
                              ),
                              endingPlace: "xxxxx",
                              nationality: controller
                                  .createTripAdsNumberPassengersCtr.text,
                              date: controller.createAdsDate == null
                                  ? null
                                  : appDateFormate(
                                      controller.createAdsDate!, "en"),
                              time: controller.createAdsTime == null
                                  ? null
                                  : appTimeFormate(
                                      controller.createAdsTime!, "en"),
                              price: double.parse(
                                controller.createTripAdsPriceCtr.text,
                              ),
                              withPackages: controller.createTripAdsIsWithPack,
                              carType:
                                  controller.createTripAdsCarTypeCtr.text == ""
                                      ? null
                                      : controller.createTripAdsCarTypeCtr.text,
                              phone: controller.createTripAdPhoneCtr.text == ""
                                  ? null
                                  : controller.createTripAdPhoneCtr.text,
                              photos: controller.createTripAdsPhotos,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
