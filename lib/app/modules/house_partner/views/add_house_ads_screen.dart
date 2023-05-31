// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/core/extensions/validator.dart';

import '../../../../core/constants/theme/app_icons.dart';
import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/progress_button.dart';
import '../../../data/models/service_type.dart';
import '../../location_getter_widgets/controllers/location_getter_widgets_controller.dart';
import '../../location_getter_widgets/views/location_getter_widgets_view.dart';
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
            leading: IconButton(
              icon: Icon(
                Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              ),
              onPressed: () {
                Get.back();
                controller.clearCreateData();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.createFormKey,
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
                    const LocationGetterWidgetsView(),
                    const SizedBox(height: 12),
                    CustomTextField(
                      name: "",
                      hint: "عدد الشركاء (إختياري)",
                      borderRadius: 8,
                      type: TextInputType.text,
                      controller: controller.createNumberPartnersCtr,
                      prefixIcon: const Icon(
                        Iconsax.people,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      name: "",
                      hint: "الجنسية (إختياري)",
                      borderRadius: 8,
                      type: TextInputType.text,
                      controller: controller.createNationalityPartnersCtr,
                      prefixIcon: const Icon(
                        Iconsax.global,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      name: "",
                      validate: Validator.validateEmpty,
                      hint: "عنوان الطلب",
                      borderRadius: 8,
                      controller: controller.createTitlePartnersCtr,
                      type: TextInputType.number,
                      prefixIcon: const Icon(
                        Iconsax.document_text,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      name: "",
                      hint: "تفاصيل الطلب",
                      borderRadius: 8,
                      controller: controller.createDescriptionPartnersCtr,
                      maxLines: 4,
                      validate: Validator.validateEmpty,
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
                        controller.pickCreateHouseAdsImages();
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
                      validate: Validator.validateMobileNotRequared,
                      controller: controller.createPhoneCtr,
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
                          if (controller.createFormKey.currentState!
                              .validate()) {
                            controller.createHouseAds(
                              animationController: animationController,
                              servicesTypeid: controller.addHousePartner,
                              location:
                                  Get.find<LocationGetterWidgetsController>()
                                      .regionName,
                              neighborhood:
                                  Get.find<LocationGetterWidgetsController>()
                                      .cityName,
                              numberPartners: controller
                                          .createNumberPartnersCtr.text !=
                                      ""
                                  ? int.parse(
                                      controller.createNumberPartnersCtr.text)
                                  : null,
                              nationality: controller
                                          .createNationalityPartnersCtr.text ==
                                      ""
                                  ? null
                                  : controller
                                      .createNationalityPartnersCtr.text,
                              title:
                                  controller.createTitlePartnersCtr.text == ""
                                      ? null
                                      : controller.createTitlePartnersCtr.text,
                              description: controller
                                          .createDescriptionPartnersCtr.text ==
                                      ""
                                  ? null
                                  : controller
                                      .createDescriptionPartnersCtr.text,
                              phone: controller.createPhoneCtr.text == ""
                                  ? null
                                  : controller.createPhoneCtr.text,
                              photos: controller.createPhotos,
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
