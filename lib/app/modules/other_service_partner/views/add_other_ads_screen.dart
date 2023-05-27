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
import '../../../../core/widgets/custom_dropdown.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/progress_button.dart';
import '../../../data/models/city_model.dart';
import '../../../data/models/region_model.dart';
import '../../../data/remote_data_source/regions_and_cities_apis.dart';
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
                    AppDropDown(
                      icon: const Icon(
                        Iconsax.location,
                        size: 20,
                        color: Colors.black,
                      ),
                      title: "المنطقة",
                      bottomSheet: FutureBuilder<RegionModel?>(
                        future: RegionsAndCitiesAPIS.getRegions(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data?.data;
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Spacer(),
                                        Expanded(
                                          child: AppText(
                                            "المنطقة",
                                            color: Colors.black,
                                            fontSize: 20,
                                            centerText: true,
                                            fontWeight: FontWeights.semiBold,
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Icon(
                                              Icons.close,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                      itemCount: data?.length ?? 0,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(height: 12),
                                      itemBuilder: (context, index) {
                                        var region = data?[index];
                                        return RadioListTile(
                                          contentPadding: EdgeInsets.zero,
                                          activeColor: ColorsManager.primary,
                                          title: Text(region?.name ?? ""),
                                          value: region,
                                          groupValue: data,
                                          onChanged: (value) {},
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(
                                valueColor: AlwaysStoppedAnimation(
                                  ColorsManager.primary,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    AppDropDown(
                      icon: const Icon(
                        Iconsax.location_tick,
                        size: 20,
                        color: Colors.black,
                      ),
                      title: "الحي",
                      bottomSheet: FutureBuilder<CityModel?>(
                        future: RegionsAndCitiesAPIS.getCities(1),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data?.data;
                            return Column(
                              children: [
                                Expanded(
                                  child: ListView.separated(
                                    padding: const EdgeInsets.all(16),
                                    itemCount: data?.length ?? 0,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 12),
                                    itemBuilder: (context, index) {
                                      var region = data?[index];
                                      return Text(region?.name ?? "");
                                    },
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(
                                valueColor: AlwaysStoppedAnimation(
                                  ColorsManager.primary,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
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
                              location: "sssss",
                              neighborhood: "xxxxx",
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
