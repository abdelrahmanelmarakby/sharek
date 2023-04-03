import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/core/constants/theme/font_manager.dart';
import 'package:sharek/core/constants/theme/sizes_manager.dart';
import 'package:sharek/core/extensions/num.dart';
import 'package:sharek/core/global/const.dart';
import 'package:sharek/core/widgets/app_text.dart';
import 'package:sharek/core/widgets/network_image.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../data/models/ads_model.dart';
import '../../home/views/home_view.dart';
import '../controllers/business_partner_controller.dart';

class BusinessPartnerDetailsScreen extends GetView<BusinessPartnerController> {
  const BusinessPartnerDetailsScreen({
    Key? key,
    required this.ad,
  }) : super(key: key);
  final Ad? ad;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.only(right: 6),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios,
                size: 16,
              ),
            ),
          ),
        ),
        actions: [
          //const SizedBox(width: 16),
          GestureDetector(
            onTap: () {},
            child: PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                      child: Row(
                    children: [
                      const Icon(
                        Iconsax.heart,
                        size: 20,
                      ),
                      12.widthSizedBox,
                      const Text("اضافة الي المفضلة"),
                    ],
                  )),
                  PopupMenuItem(
                      child: Row(
                    children: [
                      const Icon(
                        Iconsax.flag,
                        size: 20,
                      ),
                      12.widthSizedBox,
                      const Text("ابلاغ عن الاعلان"),
                    ],
                  ))
                ];
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: const Center(
                  child: Icon(
                    Icons.more_horiz_rounded,
                    size: Sizes.size20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: GetBuilder<BusinessPartnerController>(builder: (controller) {
        return Column(
          children: [
            Expanded(
              flex: 40,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ListView.separated(
                    itemCount: ad?.photos?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    physics: const PageScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final image = ad?.photos?[index];
                      return VisibilityDetector(
                        key: Key(index.toString()),
                        onVisibilityChanged: (info) {
                          controller.changeImageStepper(index.toDouble());
                        },
                        child: AppCachedNetworkImage(
                          imageUrl: image ?? dummyImage,
                          width: context.width,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  ad?.photos?.isNotEmpty ?? false
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DotsIndicator(
                            dotsCount: ad?.photos?.length ?? 0,
                            position: controller.currentImageStepper,
                            decorator: DotsDecorator(
                              activeSize: const Size(8, 8),
                              size: const Size(8, 8),
                              color: ColorsManager.white
                                  .withOpacity(.4), // Inactive color
                              activeColor: ColorsManager.white,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            Expanded(
              flex: 60,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        ad?.title ?? "",
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeights.semiBold,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          AdRowItem(
                            icon: Iconsax.clock,
                            text: ad?.createdAt1 ?? "",
                          ),
                          const Spacer(),
                          AdRowItem(
                            icon: Iconsax.location,
                            text: ad?.location ?? "",
                          )
                        ],
                      ),
                      const SizedBox(height: 13),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AdRowItem(
                            icon: Iconsax.user,
                            text: ad?.userName ?? "",
                          ),
                          const Spacer(),
                          AdRowItem(
                            icon: Iconsax.routing,
                            text: ad?.neighborhood ?? "",
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Divider(
                        color: Colors.grey.withOpacity(.2),
                      ),
                      const SizedBox(height: 16),
                      const AppText(
                        "التفاصيل",
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeights.semiBold,
                      ),
                      const SizedBox(height: 12),
                      AppText(
                        ad?.description ?? "",
                        maxLines: 10,
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeights.regular,
                      ),
                      const SizedBox(height: 16),
                      Divider(
                        color: Colors.grey.withOpacity(.2),
                      ),
                      const SizedBox(height: 16),
                      const AppText(
                        "طرق التواصل",
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeights.semiBold,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            flex: 35,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: ColorsManager.primary,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Iconsax.call,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10),
                                  AppText(
                                    "إتصال",
                                    fontSize: 14,
                                    fontWeight: FontWeights.regular,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 35,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: ColorsManager.white,
                                border: Border.all(
                                  color: ColorsManager.primary,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 11),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Iconsax.sms,
                                    color: ColorsManager.primary,
                                  ),
                                  SizedBox(width: 10),
                                  AppText(
                                    "مراسلة",
                                    fontSize: 14,
                                    color: ColorsManager.primary,
                                    fontWeight: FontWeights.regular,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(flex: 15),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Divider(
                        color: Colors.grey.withOpacity(.2),
                      ),
                      const SizedBox(height: 16),
                      const AppText(
                        "التعليقات",
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeights.semiBold,
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        name: "",
                        hint: "أكتب تعليقك هنا",
                        borderRadius: 8,
                        isResendSuffixIcon: true,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            "assets/images/send.svg",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
