// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/app/data/models/business_ad_model.dart';
import 'package:sharek/app/data/remote_data_source/business_ads.dart';
import 'package:sharek/app/modules/travel_partner/widgets/comment_item.dart';
import 'package:sharek/app/modules/travel_partner/widgets/trip_ads_photos_list_view.dart';
import 'package:sharek/core/constants/theme/font_manager.dart';
import 'package:sharek/core/constants/theme/sizes_manager.dart';
import 'package:sharek/core/extensions/num.dart';
import 'package:sharek/core/global/const.dart';
import 'package:sharek/core/widgets/app_text.dart';
import 'package:sharek/core/widgets/network_image.dart';
import 'package:sharek/core/widgets/progress_button.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/services/get_storage_helper.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../routes/app_pages.dart';
import '../../chats/chat_screen.dart';
import '../../home/views/home_view.dart';
import '../controllers/business_partner_controller.dart';

class BusinessPartnerDetailsScreen extends GetView<BusinessPartnerController> {
  const BusinessPartnerDetailsScreen({
    Key? key,
    required this.adId,
    required this.isUserAds,
  }) : super(key: key);
  final int adId;
  final bool isUserAds;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessPartnerController>(
      builder: (controller) {
        return FutureBuilder<BusinessPartnerAdModel?>(
          future: BusinessPartnerAPI.getBusinessAdById(adId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final ads = snapshot.data?.data;
              return Scaffold(
                extendBodyBehindAppBar: true,
                body: NestedScrollView(
                  controller: controller.scrollController,
                  floatHeaderSlivers: true,
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    log(innerBoxIsScrolled.toString());
                    return [
                      SliverAppBar(
                        floating: false,
                        pinned: true,
                        expandedHeight: MediaQuery.of(context).size.height / 3,
                        forceElevated: innerBoxIsScrolled,
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
                          GestureDetector(
                            onTap: () {
                              controller.addToFavorites(id: adId);
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
                                  Iconsax.heart,
                                  size: Sizes.size20,
                                  color: ColorsManager.red,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          if (innerBoxIsScrolled)
                            const Icon(
                              Icons.share_outlined,
                              size: 20,
                            )
                          else
                            PopupMenuButton(
                              onSelected: (val) async {
                                if (val == "/report") {
                                  Get.dialog(
                                    Dialog(
                                      child: Container(
                                        width: context.width - 40,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const AppText(
                                              "ابلاغ",
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeights.semiBold,
                                            ),
                                            const SizedBox(height: 12),
                                            CustomTextField(
                                              name: "",
                                              hint: "",
                                              borderRadius: 8,
                                              controller: controller.reportCtr,
                                              suffixIcon: const SizedBox(),
                                              isResendSuffixIcon: true,
                                              type: TextInputType.text,
                                            ),
                                            const SizedBox(height: 24),
                                            AppProgressButton(
                                              onPressed: (anim) {
                                                controller.reportCtr.text == ""
                                                    ? null
                                                    : controller.createReport(
                                                        id: adId,
                                                        report: controller
                                                            .reportCtr.text,
                                                        animationController:
                                                            anim,
                                                      );
                                              },
                                              text: "ابلاغ",
                                              width: context.width,
                                              backgroundColor:
                                                  ColorsManager.primary,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return isUserAds
                                    ? [
                                        PopupMenuItem(
                                          value: "/share",
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.share_outlined,
                                                size: 20,
                                              ),
                                              12.widthSizedBox,
                                              const Text("مشاركة الاعلان"),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: "/report",
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Iconsax.edit,
                                                size: 20,
                                              ),
                                              12.widthSizedBox,
                                              const Text(
                                                "تعديل الإعلان",
                                              ),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: "/report",
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.delete_outlined,
                                                size: 20,
                                              ),
                                              12.widthSizedBox,
                                              const Text(
                                                "حذف الإعلان",
                                              ),
                                            ],
                                          ),
                                        )
                                      ]
                                    : [
                                        PopupMenuItem(
                                          value: "/share",
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.share_outlined,
                                                size: 20,
                                              ),
                                              12.widthSizedBox,
                                              const Text("مشاركة الاعلان"),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: "/report",
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Iconsax.flag,
                                                size: 20,
                                              ),
                                              12.widthSizedBox,
                                              const Text(
                                                "ابلاغ عن الاعلان",
                                              ),
                                            ],
                                          ),
                                        ),
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
                          const SizedBox(width: 16),
                        ],
                        flexibleSpace: LayoutBuilder(
                          builder: (
                            BuildContext context,
                            BoxConstraints constraints,
                          ) {
                            return FlexibleSpaceBar(
                              centerTitle: true,
                              title: const AnimatedOpacity(
                                duration: Duration(milliseconds: 300),
                                opacity: 1.0,
                              ),
                              background: GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => AdsPhotosListView(
                                      photos: ads?.photos ?? [],
                                    ),
                                  );
                                },
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    PageView.builder(
                                      itemCount: ads?.photos?.length ?? 0,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final image = ads?.photos?[index];
                                        return AppCachedNetworkImage(
                                          imageUrl: image ?? dummyImage,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                    ads?.photos?.isNotEmpty ?? false
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DotsIndicator(
                                              dotsCount:
                                                  ads?.photos?.length ?? 0,
                                              position: 0,
                                              decorator: DotsDecorator(
                                                activeSize: const Size(8, 8),
                                                size: const Size(8, 8),
                                                color: ColorsManager.white
                                                    .withOpacity(
                                                        .4), // Inactive color
                                                activeColor:
                                                    ColorsManager.white,
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ];
                  },
                  body: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            ads?.title ?? "",
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeights.semiBold,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              AdRowItem(
                                icon: Iconsax.clock,
                                text: ads?.createdAt1 ?? "",
                              ),
                              AdRowItem(
                                icon: Iconsax.location,
                                text: ads?.location ?? "",
                              ),
                              AdRowItem(
                                icon: Iconsax.location_tick,
                                text: ads?.neighborhood ?? "",
                              ),
                            ],
                          ),
                          const SizedBox(height: 13),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AdRowItem(
                                icon: Iconsax.user,
                                text: ads?.userName ?? "",
                                onTap: () {
                                  Get.toNamed(
                                    Routes.ANOTHER_USER_PROFILE,
                                    arguments: {
                                      "userId": ads?.userId,
                                    },
                                  );
                                },
                              ),
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
                          SelectableText(ads?.description ?? ""),
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
                                child: GestureDetector(
                                  onTap: () {
                                    controller.makePhoneCall(
                                      ads?.phone.toString() ?? "",
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: ColorsManager.primary,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 35,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => ChatScreen(
                                        hisId: "${ads?.userId ?? 0}",
                                        myId: CacheHelper.getUserId.toString(),
                                        hisName: ads?.userName ?? "بدون اسم",
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: ColorsManager.white,
                                      border: Border.all(
                                        color: ColorsManager.primary,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 11),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                          const SizedBox(height: 8),
                          CustomTextField(
                            name: "",
                            hint: "أكتب تعليقك هنا",
                            borderRadius: 8,
                            controller: controller.createCommentCtr,
                            onChange: controller.onChangedComment,
                            isResendSuffixIcon: true,
                            type: TextInputType.text,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: () {
                                  controller.isText
                                      ? controller.createComment(
                                          comment:
                                              controller.createCommentCtr.text,
                                          id: ads?.advertisementId ?? 0,
                                        )
                                      : null;
                                },
                                child: SvgPicture.asset(
                                  "assets/images/send.svg",
                                  color: !controller.isText
                                      ? Colors.grey.withOpacity(.4)
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: ads?.comments?.length ?? 0,
                            itemBuilder: (context, index) {
                              Comments? comment = ads?.comments?[index];
                              return CommentItemWidget(
                                comment: comment?.comment ?? "",
                                createdAt: comment?.createdAt ?? "",
                                image: comment?.avatar ?? dummyImage,
                                username: comment?.userName ?? "",
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: AppText(
                  "لا يوجد بيانات",
                  color: Colors.black,
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation(ColorsManager.primary),
                ),
              );
            }
          },
        );
      },
    );
  }
}
