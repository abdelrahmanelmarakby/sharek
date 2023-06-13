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
import '../../location_getter_widgets/controllers/location_getter_widgets_controller.dart';
import '../../location_getter_widgets/views/location_getter_widgets_view.dart';
import '../controllers/other_service_partner_controller.dart';

class AddOtherAdsScreen extends GetView<OtherServicePartnerController> {
  const AddOtherAdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtherServicePartnerController>(
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
                    const SizedBox(height: 16),
                    const LocationGetterWidgetsView(),
                    const SizedBox(height: 12),
                    CustomTextField(
                      name: "",
                      validate: Validator.validateEmpty,
                      hint: "عنوان الطلب",
                      borderRadius: 8,
                      controller: controller.createTitlePartnersCtr,
                      type: TextInputType.text,
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
                      prefixIcon: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          children: [
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
                              location:
                                  Get.find<LocationGetterWidgetsController>()
                                      .regionName,
                              neighborhood:
                                  Get.find<LocationGetterWidgetsController>()
                                      .cityName,
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
