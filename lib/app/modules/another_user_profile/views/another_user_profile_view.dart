import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/app/data/remote_data_source/profile_apis.dart';
import 'package:sharek/core/extensions/export.dart';
import 'package:sharek/core/global/const.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/constants/theme/sizes_manager.dart';
import '../../../../core/constants/theme/styles_manager.dart';
import '../../../../core/services/get_storage_helper.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/network_image.dart';
import '../../../data/models/another_user_profile_view.dart';
import '../../business_partner/bindings/business_partner_binding.dart';
import '../../business_partner/views/business_partner_details_screen.dart';
import '../../chats/chat_screen.dart';
import '../../home/views/home_view.dart';
import '../../house_partner/bindings/house_partner_binding.dart';
import '../../house_partner/views/house_ads_details_screen.dart';
import '../../other_service_partner/bindings/other_service_partner_binding.dart';
import '../../other_service_partner/views/other_ads_details_screen.dart';
import '../../sake_partner/bindings/sake_partner_binding.dart';
import '../../sake_partner/views/sake_ads_details_screen.dart';
import '../../travel_partner/bindings/travel_partner_binding.dart';
import '../../travel_partner/views/travel_partner_details_screen.dart';
import '../controllers/another_user_profile_controller.dart';

class AnotherUserProfileView extends GetView<AnotherUserProfileController> {
  const AnotherUserProfileView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnotherUserProfileController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(context),
        body: RefreshIndicator(
          onRefresh: () {
            return Get.forceAppUpdate();
          },
          child: FutureBuilder<AnotherUserProfile?>(
            future: ProfileApis.getAnotherUserProfile(Get.arguments["userId"]),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Data? user = snapshot.data?.data;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 70,
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: AppCachedNetworkImage(
                                      imageUrl:
                                          user?.user?.avatar ?? dummyImage,
                                      fit: BoxFit.cover,
                                      width: 60,
                                      height: 60,
                                      isCircular: true,
                                      isLoaderShimmer: true,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          user?.user?.name ?? "",
                                          color: Colors.black,
                                          fontSize: FontSize.xLarge,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        AppText(
                                          "انضم ${user?.user?.createdAt2}",
                                          color: Colors.grey,
                                          fontSize: FontSize.medium,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        const SizedBox(height: 4),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 30,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  user?.user?.phoneStatus == 0 ||
                                          user?.user?.phone == null
                                      ? const SizedBox()
                                      : GestureDetector(
                                          onTap: () {
                                            controller.makePhoneCall(
                                              user?.user?.phone.toString() ??
                                                  "",
                                            );
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: const BoxDecoration(
                                              color: ColorsManager.primary,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Iconsax.call,
                                              color: ColorsManager.white,
                                            ),
                                          ),
                                        ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        () => ChatScreen(
                                          hisId: "${user?.user?.id ?? 0}",
                                          myId:
                                              CacheHelper.getUserId.toString(),
                                          hisName:
                                              user?.user?.name ?? "بدون اسم",
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: ColorsManager.white,
                                        border: Border.all(
                                          color: ColorsManager.primary,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Iconsax.sms,
                                        color: ColorsManager.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "الإعلانات السابقة",
                          style: StylesManager.bold(fontSize: FontSize.xlarge),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: user?.advertisement?.length ?? 0,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            var ad = user?.advertisement?[index];
                            return GestureDetector(
                              onTap: () {
                                if (ad?.serviceId == 1) {
                                  Get.to(
                                    () => BusinessPartnerDetailsScreen(
                                      adId: ad?.advertisementId ?? 0,
                                      isUserAds: false,
                                    ),
                                    binding: BusinessPartnerBinding(),
                                  );
                                } else if (ad?.serviceId == 2) {
                                  Get.to(
                                    () => TravelPartnerDetailsScreen(
                                      id: ad?.advertisementId ?? 0,
                                      isUserAds: false,
                                    ),
                                    binding: TravelPartnerBinding(),
                                  );
                                } else if (ad?.serviceId == 3) {
                                  Get.to(
                                    () => SakePartnerDetailsScreen(
                                      id: ad?.advertisementId ?? 0,
                                      isUserAds: false,
                                    ),
                                    binding: SakePartnerBinding(),
                                  );
                                } else if (ad?.serviceId == 4) {
                                  Get.to(
                                    () => HousePartnerDetailsScreen(
                                      id: ad?.advertisementId ?? 0,
                                      isUserAds: false,
                                    ),
                                    binding: HousePartnerBinding(),
                                  );
                                } else {
                                  Get.to(
                                    () => OtherPartnerDetailsScreen(
                                      id: ad?.advertisementId ?? 0,
                                      isUserAds: false,
                                    ),
                                    binding: OtherServicePartnerBinding(),
                                  );
                                }
                              },
                              child: AdCard(ad: ad),
                            );
                          },
                        )
                      ],
                    ),
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
          ),
        ),
      );
    });
  }
}

AppBar appBar(BuildContext context) {
  return AppBar(
    leading: GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        height: 40,
        width: 40,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.only(right: 6),
        decoration: const BoxDecoration(
          color: Color(0xFFF7F7F9),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
        ),
      ),
    ),
    actions: [
      PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.share,
                  color: ColorsManager.grey,
                  size: Sizes.size20,
                ),
                Sizes.size4.widthSizedBox,
                Text(
                  "مشاركة الحساب",
                  style: StylesManager.medium(fontSize: FontSize.medium),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            child: Row(
              children: [
                const Icon(
                  Icons.block,
                  color: ColorsManager.grey,
                  size: Sizes.size20,
                ),
                Sizes.size4.widthSizedBox,
                Text(
                  "ابلاغ",
                  style: StylesManager.medium(fontSize: FontSize.medium),
                ),
              ],
            ),
          ),
        ],
        child: Container(
          height: 40,
          width: 40,
          margin: const EdgeInsets.only(left: 8),
          decoration: const BoxDecoration(
            color: Color(0xFFF7F7F9),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Center(
            child: Icon(
              Icons.more_horiz_rounded,
            ),
          ),
        ),
      ),
    ],
  );
}
