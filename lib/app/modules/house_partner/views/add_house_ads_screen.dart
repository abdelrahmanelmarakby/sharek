// ignore_for_file: unused_local_variable

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/core/extensions/validator.dart';

import '../../../../core/constants/theme/app_icons.dart';
import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_dropdown.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/progress_button.dart';
import '../../../data/models/trip_services_type_model.dart';
import '../../travel_partner/widgets/services_type_item.dart';
import '../controllers/house_partner_controller.dart';

class AddHouseAdsScreen extends GetView<HousePartnerController> {
  const AddHouseAdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HousePartnerController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('إضافة إعلان'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.createHouseAdsFormKey,
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
                      children: houseServicesTypes
                          .map(
                            (e) => Container(
                              padding: EdgeInsets.only(
                                left: controller.addHousePartner == 10 ? 6 : 0,
                                right: controller.addHousePartner == 11 ? 6 : 0,
                              ),
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: ServicesItem(
                                activeIndex: controller.addHousePartner,
                                index: e.serviceTypeId ?? 0,
                                title: e.name ?? "",
                                onTap: () {
                                  controller.changeAddHousePartnerState(
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
                      title: "المنطقة",
                      bottomSheet: Container(),
                    ),
                    const SizedBox(height: 12),
                    AppDropDown(
                      icon: const Icon(
                        Iconsax.location_tick,
                        size: 20,
                        color: Colors.black,
                      ),
                      title: "الحي",
                      bottomSheet: Container(),
                    ),
                    const SizedBox(height: 12),
                    controller.addHousePartner == 10
                        ? CustomTextField(
                            name: "",
                            hint: "عدد الشركاء (إختياري)",
                            borderRadius: 8,
                            type: TextInputType.text,
                            validate: Validator.validateEmpty,
                            controller:
                                controller.createHouseAdnumberPartnersCtr,
                            prefixIcon: const Icon(
                              Iconsax.people,
                              color: Colors.black,
                            ),
                          )
                        : const SizedBox(),
                    controller.addHousePartner == 10
                        ? const SizedBox(height: 12)
                        : const SizedBox(),
                    controller.addHousePartner == 10
                        ? CustomTextField(
                            name: "",
                            hint: "الجنسية (إختياري)",
                            borderRadius: 8,
                            type: TextInputType.text,
                            validate: Validator.validateEmpty,
                            controller:
                                controller.createHouseAdnumberPartnersCtr,
                            prefixIcon: const Icon(
                              Iconsax.global,
                              color: Colors.black,
                            ),
                          )
                        : const SizedBox(),
                    controller.addHousePartner == 10
                        ? const SizedBox(height: 12)
                        : const SizedBox(),
                    const CustomTextField(
                      name: "",
                      validate: Validator.validateEmpty,
                      hint: "عنوان الطلب",
                      borderRadius: 8,
                      type: TextInputType.number,
                      prefixIcon: Icon(
                        Iconsax.document_text,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      name: "",
                      hint: "تفاصيل الطلب",
                      borderRadius: 8,
                      maxLines: 4,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          children: const [
                            Icon(
                              Iconsax.document_text,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
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
                      controller: controller.createHouseAdPhoneCtr,
                      prefixIcon: const Icon(
                        Iconsax.call,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 27),
                    AppProgressButton(
                      width: context.width,
                      text: "إضافة إعلان جديد",
                      onPressed: (animationController) {
                        // if (controller.createTripAdsFormKey.currentState!
                        //         .validate() &&
                        //     controller.createAdsDate != null &&
                        //     controller.createAdsTime != null) {
                        //   controller.createTripAds(
                        //     animationController: animationController,
                        //     servicesTypeid: controller.addTravelPartner,
                        //     startingPlace: "sssss",
                        //     numberPassengers: int.parse(
                        //       controller.createTripAdsNumberPassengersCtr.text,
                        //     ),
                        //     endingPlace: "xxxxx",
                        //     nationality: controller
                        //         .createTripAdsNumberPassengersCtr.text,
                        //     date: controller.createAdsDate == null
                        //         ? null
                        //         : appDateFormate(
                        //             controller.createAdsDate!, "en"),
                        //     time: controller.createAdsTime == null
                        //         ? null
                        //         : appTimeFormate(
                        //             controller.createAdsTime!, "en"),
                        //     price: double.parse(
                        //       controller.createTripAdsPriceCtr.text,
                        //     ),
                        //     withPackages: controller.createTripAdsIsWithPack,
                        //     carType:
                        //         controller.createTripAdsCarTypeCtr.text == ""
                        //             ? null
                        //             : controller.createTripAdsCarTypeCtr.text,
                        //     phone: controller.createTripAdPhoneCtr.text == ""
                        //         ? null
                        //         : controller.createTripAdPhoneCtr.text,
                        //     photos: controller.createTripAdsPhotos,
                        //   );
                        // }
                      },
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
