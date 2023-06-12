import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/theme/app_icons.dart';
import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/extensions/validator.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/progress_button.dart';
import '../../../data/models/business_ad_model.dart';
import '../../location_getter_widgets/controllers/location_getter_widgets_controller.dart';
import '../../location_getter_widgets/views/location_getter_widgets_view.dart';
import '../controllers/business_partner_controller.dart';

class EditBusinessPartnerAdsScreen extends GetView<BusinessPartnerController> {
  const EditBusinessPartnerAdsScreen({
    Key? key,
    this.ads,
  }) : super(key: key);
  final Data? ads;
  @override
  Widget build(BuildContext context) {
    controller.editTitlePartnersCtr.text = ads?.title ?? "";
    controller.editDescriptionPartnersCtr.text = ads?.description ?? "";
    controller.editAdPhoneCtr.text =
        ads?.phone != null ? ads?.phone.toString() ?? "" : "";
    controller.editPhotos = ads?.photos?.map((e) => File(e)).toList();
    log(controller.editPhotos?.length.toString() ?? "0");
    Get.find<LocationGetterWidgetsController>().regionName =
        ads?.location ?? "";
    Get.find<LocationGetterWidgetsController>().cityName =
        ads?.neighborhood ?? "";
    Get.find<LocationGetterWidgetsController>().districtName = null;
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل إعلان'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: controller.editAdsFormKey,
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
                //const FiltersList(),
                const SizedBox(height: 16),
                const LocationGetterWidgetsView(showDistrict: true),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F9),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFE4E4E5),
                    ),
                  ),
                  width: double.infinity,
                  child: const ExpansionTile(
                    leading: Icon(
                      Iconsax.happyemoji,
                      color: Colors.black,
                    ),
                    title: AppText(
                      "النوع",
                      fontSize: 16,
                      color: ColorsManager.black,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  name: "",
                  hint: "عنوان الطلب",
                  borderRadius: 8,
                  controller: controller.editTitlePartnersCtr,
                  validate: Validator.validateEmpty,
                  prefixIcon: const Icon(
                    Iconsax.document,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  name: "",
                  hint: "تفاصيل الطلب",
                  borderRadius: 8,
                  controller: controller.editDescriptionPartnersCtr,
                  maxLines: 4,
                  validate: Validator.validateEmpty,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      children: const [
                        Icon(
                          Iconsax.document,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    controller.pickeditAdsImages();
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
                            "رفع الصور ",
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
                  controller: controller.editAdPhoneCtr,
                  prefixIcon: const Icon(
                    Iconsax.call,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 27),
                Center(
                  child: AppProgressButton(
                    width: context.width,
                    text: "تعديل إعلان جديد",
                    onPressed: (animationController) {
                      controller.createTripAds(
                        id: ads?.advertisementId ?? 0,
                        update: true,
                        type: 1,
                        servicesTypeid: 1,
                        animationController: animationController,
                        location: Get.find<LocationGetterWidgetsController>()
                            .regionName,
                        neighborhood:
                            Get.find<LocationGetterWidgetsController>()
                                .cityName,
                        title: controller.createTitlePartnersCtr.text == ""
                            ? null
                            : controller.createTitlePartnersCtr.text,
                        description:
                            controller.createDescriptionPartnersCtr.text == ""
                                ? null
                                : controller.createDescriptionPartnersCtr.text,
                        phone: controller.createAdPhoneCtr.text == ""
                            ? null
                            : controller.createAdPhoneCtr.text,
                        photos: controller.createPhotos,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
