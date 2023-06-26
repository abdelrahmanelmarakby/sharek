import 'package:animate_do/animate_do.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/app/modules/travel_partner/widgets/services_type_item.dart';
import 'package:sharek/core/extensions/num.dart';

import '../../../../core/constants/theme/app_icons.dart';
import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/constants/theme/sizes_manager.dart';
import '../../../../core/extensions/validator.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/progress_button.dart';
import '../../../data/models/service_type.dart';
import '../../location_getter_widgets/controllers/location_getter_widgets_controller.dart';
import '../../location_getter_widgets/views/location_getter_widgets_view.dart';
import '../controllers/business_partner_controller.dart';
import '../widgets/type_drop_down.dart';

class AddBusinessPartnerAdsScreen extends GetView<BusinessPartnerController> {
  const AddBusinessPartnerAdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة إعلان'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: controller.createAdsFormKey,
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
                GetBuilder<BusinessPartnerController>(
                  builder: (controller) => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(
                      3,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ServicesItem(
                          activeIndex: controller.businessPartner ?? 0,
                          index:
                              businessServicesTypes[index].serviceTypeId ?? 0,
                          title: businessServicesTypes[index].name ?? "",
                          onTap: () {
                            if (controller.businessPartner ==
                                businessServicesTypes[index].serviceTypeId) {
                              controller.changeBusinessPartnerState(
                                null,
                              );
                              return;
                            }

                            controller.changeBusinessPartnerState(
                              businessServicesTypes[index].serviceTypeId ?? 0,
                            );
                          },
                        ),
                      ),
                    )),
                  ),
                ),
                //const FiltersList(),
                const SizedBox(height: 16),
                const LocationGetterWidgetsView(showDistrict: true),
                const SizedBox(height: 12),
                const TypeDropDown(),
                const SizedBox(height: 12),
                CustomTextField(
                  name: "",
                  hint: "عنوان الطلب",
                  borderRadius: 8,
                  controller: controller.createTitlePartnersCtr,
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
                  controller: controller.createDescriptionPartnersCtr,
                  maxLines: 20,
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
                GetBuilder<BusinessPartnerController>(
                  builder: (controller) {
                    return (controller.createPhotos?.isNotEmpty ?? false)
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: SizedBox(
                              height: 80,
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    Sizes.size10.w(context).widthSizedBox,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.createPhotos!.length,
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
                                            controller.createPhotos![index],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 5,
                                        right: 5,
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.createPhotos
                                                ?.removeAt(index);
                                            controller.update();
                                          },
                                          child: const Icon(
                                            Icons.cancel,
                                            color: ColorsManager.error,
                                          ),
                                        ),
                                      ),
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
                  validate: Validator.validateMobileNotRequared,
                  controller: controller.createAdPhoneCtr,
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
                      if (controller.businessPartner == null) {
                        BotToast.showText(text: "برجاء اختيار نوع الخدمة");
                      }
                      if (controller.bussinessTypeModel == null) {
                        BotToast.showText(text: "برجاء اختيار النوع ");
                      }
                      if (controller.createAdsFormKey.currentState!
                          .validate()) {
                        controller.createTripAds(
                          type: controller.bussinessTypeModel?.id,
                          servicesTypeid: controller.businessPartner,
                          animationController: animationController,
                          district: Get.find<LocationGetterWidgetsController>()
                              .districtName,
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
                                  : controller
                                      .createDescriptionPartnersCtr.text,
                          phone: controller.createAdPhoneCtr.text == ""
                              ? null
                              : controller.createAdPhoneCtr.text,
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
  }
}
