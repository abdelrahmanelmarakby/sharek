// ignore_for_file: unused_local_variable

import 'package:animate_do/animate_do.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/core/extensions/num.dart';
import 'package:sharek/core/extensions/validator.dart';

import '../../../../core/constants/theme/app_icons.dart';
import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/constants/theme/sizes_manager.dart';
import '../../../../core/constants/theme/styles_manager.dart';
import '../../../../core/extensions/input_formatter.dart';
import '../../../../core/global/const.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_dropdown.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/progress_button.dart';
import '../../../../core/widgets/src/radio_button_builder.dart';
import '../../../../core/widgets/src/radio_group.dart';
import '../../../data/models/service_type.dart';
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
                            minimumDate: DateTime.now(),
                            minimumYear: DateTime.now().year,
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
                    if (controller.createAdsDateError != null)
                      Column(
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            controller.createAdsDateError!,
                            style: StylesManager.regular(
                                fontSize: FontSize.small,
                                color: ColorsManager.error),
                          ),
                        ],
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
                    if (controller.createAdsTime != null)
                      Column(
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            controller.createAdsTimeErorr!,
                            style: StylesManager.regular(
                                fontSize: FontSize.small,
                                color: ColorsManager.error),
                          ),
                        ],
                      ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      name: "",
                      hint: "السعر المتوقع",
                      borderRadius: 8,
                      controller: controller.createTripAdsPriceCtr,
                      validate: Validator.validateEmpty,
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
                        const Expanded(
                          child: AppText(
                            "هل تقبل طرود؟",
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
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                SharekIcons.upload_1,
                                color: ColorsManager.primary,
                              ),
                              SizedBox(width: 10),
                              AppText(
                                "رفع الصور  ",
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeights.light,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GetBuilder<TravelPartnerController>(
                      builder: (controller) {
                        return (controller.createTripAdsPhotos?.isNotEmpty ??
                                false)
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: SizedBox(
                                  height: 80,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        Sizes.size10.w(context).widthSizedBox,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        controller.createTripAdsPhotos!.length,
                                    itemBuilder: (context, index) => FadeIn(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.file(
                                                controller.createTripAdsPhotos![
                                                    index],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              top: 5,
                                              right: 5,
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.createTripAdsPhotos
                                                      ?.removeAt(index);
                                                  controller.update();
                                                },
                                                child: const Icon(
                                                  Icons.cancel,
                                                  color: ColorsManager.error,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox();
                      },
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
                          print(controller.createAdsTime.toString() +
                              controller.createAdsDate.toString());
                          controller.createTripAdsFormKey.currentState!
                              .validate();
                          if (controller.createAdsDate == null) {
                            controller.createAdsDateError =
                                "يرجى تحديد تاريخ الرحلة";
                            controller.update();
                          } else {
                            controller.createAdsDateError = null;
                            controller.update();
                          }

                          if (controller.createAdsTime == null) {
                            controller.createAdsTimeErorr =
                                "يرجى تحديد ساعة الرحلة";
                            controller.update();
                          } else {
                            controller.createAdsTimeErorr = null;
                            controller.update();
                          }
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
