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
import '../../location_getter_widgets/views/location_getter_widgets_view.dart';
import '../../travel_partner/widgets/services_type_item.dart';
import '../controllers/sake_partner_controller.dart';
import '../widgets/create_ads_quantity_section.dart';

class AddSakeAdsScreen extends GetView<SakePartnerController> {
  const AddSakeAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SakePartnerController>(
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
                      children: sacrificeServicesTypes
                          .map(
                            (e) => Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: ServicesItem(
                                  activeIndex:
                                      controller.createSacrificePartner,
                                  index: e.serviceTypeId ?? 0,
                                  title: e.name ?? "",
                                  onTap: () {
                                    controller
                                        .changeCreateSacrificePartnerState(
                                      e.serviceTypeId ?? 0,
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: controller.sacrificeType
                          .map(
                            (e) => Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: ServicesItem(
                                  activeIndex: controller
                                          .createSacrificeTypeItem
                                          .serviceTypeId ??
                                      0,
                                  index: e.serviceTypeId ?? 0,
                                  title: e.name ?? "",
                                  onTap: () {
                                    controller
                                        .changeCreateSacrificeTypeState(e);
                                  },
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                    const LocationGetterWidgetsView(),
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
                        controller.pickCreateAdsImages();
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
                    controller.createSacrificePartner == 8
                        ? const SizedBox()
                        : const SizedBox(height: 16),
                    controller.createSacrificePartner == 8
                        ? const SizedBox()
                        : const CreateAdsQuantitySection(),
                    const SizedBox(height: 27),
                    Center(
                      child: AppProgressButton(
                        width: context.width,
                        text: "إضافة إعلان جديد",
                        onPressed: (animationController) {
                          if (controller.createFormKey.currentState!
                              .validate()) {
                            controller.createSacrificePartner == 8
                                ? controller.createSakeAds(
                                    animationController: animationController,
                                    location: "sssss",
                                    neighborhood: "xxxxx",
                                    sacrificeType:
                                        controller.createSacrificeTypeItem.name,
                                    servicesTypeid:
                                        controller.createSacrificePartner,
                                    title: controller
                                                .createTitlePartnersCtr.text ==
                                            ""
                                        ? null
                                        : controller
                                            .createTitlePartnersCtr.text,
                                    description: controller
                                                .createDescriptionPartnersCtr
                                                .text ==
                                            ""
                                        ? null
                                        : controller
                                            .createDescriptionPartnersCtr.text,
                                    phone: controller.createPhoneCtr.text == ""
                                        ? null
                                        : controller.createPhoneCtr.text,
                                    photos: controller.createPhotos,
                                  )
                                : controller.eighth == 0 &&
                                        controller.half == 0 &&
                                        controller.quarter == 0 &&
                                        controller.third == 0
                                    ? null
                                    : controller.createSakeAds(
                                        animationController:
                                            animationController,
                                        location: "sssss",
                                        neighborhood: "xxxxx",
                                        title: controller.createTitlePartnersCtr
                                                    .text ==
                                                ""
                                            ? null
                                            : controller
                                                .createTitlePartnersCtr.text,
                                        description: controller
                                                    .createDescriptionPartnersCtr
                                                    .text ==
                                                ""
                                            ? null
                                            : controller
                                                .createDescriptionPartnersCtr
                                                .text,
                                        phone: controller.createPhoneCtr.text ==
                                                ""
                                            ? null
                                            : controller.createPhoneCtr.text,
                                        photos: controller.createPhotos,
                                        eighthPrice: controller.eighth == 0
                                            ? null
                                            : int.parse(
                                                controller
                                                    .createEighthPriceCtr.text,
                                              ),
                                        eighthQuantity: controller.eighth == 0
                                            ? null
                                            : controller.eighth,
                                        halfPrice: controller.half == 0
                                            ? null
                                            : int.parse(
                                                controller
                                                    .createHalfPriceCtr.text,
                                              ),
                                        halfQuantity: controller.half == 0
                                            ? null
                                            : controller.half,
                                        quarterPrice: controller.quarter == 0
                                            ? null
                                            : int.parse(
                                                controller
                                                    .createQuarterPriceCtr.text,
                                              ),
                                        quarterQuantity: controller.quarter == 0
                                            ? null
                                            : controller.quarter,
                                        sacrificeType: controller
                                            .createSacrificeTypeItem.name,
                                        servicesTypeid:
                                            controller.createSacrificePartner,
                                        thirdPrice: controller.third == 0
                                            ? null
                                            : controller.third,
                                        thirdQuantity: controller.third == 0
                                            ? null
                                            : int.parse(
                                                controller
                                                    .createThirdPriceCtr.text,
                                              ),
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
