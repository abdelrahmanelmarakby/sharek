// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_typing_uninitialized_variables
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:sharek/app/data/models/home_model.dart';
import 'package:sharek/app/modules/home/bindings/home_binding.dart';
import 'package:sharek/app/modules/house_partner/bindings/house_partner_binding.dart';
import 'package:sharek/app/modules/other_service_partner/bindings/other_service_partner_binding.dart';
import 'package:sharek/app/modules/sake_partner/bindings/sake_partner_binding.dart';
import 'package:sharek/app/modules/travel_partner/bindings/travel_partner_binding.dart';
import 'package:sharek/app/routes/app_pages.dart';
import 'package:sharek/core/constants/theme/colors_manager.dart';
import 'package:sharek/core/constants/theme/font_manager.dart';
import 'package:sharek/core/constants/theme/sizes_manager.dart';
import 'package:sharek/core/constants/theme/styles_manager.dart';
import 'package:sharek/core/extensions/num.dart';
import 'package:sharek/core/extensions/widget.dart';
import 'package:sharek/core/global/const.dart';
import 'package:sharek/core/language/local_keys.dart';
import 'package:sharek/core/widgets/app_text.dart';
import 'package:sharek/core/widgets/custom_text_field.dart';

import '../../../data/remote_data_source/home_apis.dart';
import '../../business_partner/bindings/business_partner_binding.dart';
import '../../business_partner/views/add_business_partner_ads_screen.dart';
import '../../business_partner/views/business_partner_details_screen.dart';
import '../../house_partner/views/add_house_ads_screen.dart';
import '../../house_partner/views/house_ads_details_screen.dart';
import '../../other_service_partner/views/add_other_ads_screen.dart';
import '../../other_service_partner/views/other_ads_details_screen.dart';
import '../../sake_partner/views/add_sake_ads_screen.dart';
import '../../sake_partner/views/sake_ads_details_screen.dart';
import '../../travel_partner/views/add_trip_ads_screen.dart';
import '../../travel_partner/views/travel_partner_details_screen.dart';
import '../controllers/home_controller.dart';
import 'home_search_screen.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put<HomeController>(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'شريك',
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Get.forceAppUpdate();
        },
        child: FutureBuilder<HomeModel?>(
          future: HomeAPI.getHome(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final HomeModel? homeData = snapshot.data;
              log(homeData.toString());
              return SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      CustomTextField(
                        name: LocalKeys.search,
                        hint: "أبحث هنا",
                        readOnly: true,
                        onTap: () {
                          Get.to(
                            () => const HomeSearchScreen(),
                            binding: HomeBinding(),
                          );
                        },
                        prefixIcon: const Icon(Iconsax.search_normal),
                      ),
                      Sizes.size16.h(context).heightSizedBox,
                      const ServicesList(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "الاعلانات الجديدة",
                            style:
                                StylesManager.bold(fontSize: FontSize.xlarge),
                          ),
                          Sizes.size10.heightSizedBox,
                          ...List.generate(
                            20,
                            (index) {
                              NewAdvertisements? ad =
                                  homeData?.data?.newAdvertisements?[index];
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
                          ),
                        ],
                      )
                    ],
                  ).horizontalScreenPadding,
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
  }
}

class AdCard extends StatelessWidget {
  const AdCard({
    super.key,
    required this.ad,
  });

  final ad;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        height: context.height / 6,
        width: context.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: .5, color: ColorsManager.veryLightGrey),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          (ad?.title) ?? "",
                          overflow: TextOverflow.clip,
                          style: StylesManager.bold(fontSize: FontSize.large),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          AdRowItem(
                              icon: Iconsax.clock, text: ad?.createdAt1 ?? ""),
                          AdRowItem(
                              icon: Iconsax.location, text: ad?.location ?? "")
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AdRowItem(
                            icon: Iconsax.user,
                            text: ad?.userName ?? "",
                            // onTap: () {
                            //   Get.toNamed(
                            //     Routes.ANOTHER_USER_PROFILE,
                            //     arguments: {
                            //       "userId": ad?.userId,
                            //     },
                            //   );
                            // },
                          ),
                          AdRowItem(
                            icon: Iconsax.routing,
                            text: ad?.neighborhood ?? "",
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    ad?.photos?.isNotEmpty ?? false
                        ? ad?.photos?.first ?? ""
                        : dummyImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdRowItem extends StatelessWidget {
  const AdRowItem({
    Key? key,
    required this.icon,
    required this.text,
    this.flex = 1,
    this.onTap,
    this.maxLines = 1,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final int flex;
  final int maxLines;

  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              icon,
              color: ColorsManager.grey,
              size: Sizes.size20,
            ),
            Sizes.size4.widthSizedBox,
            Expanded(
              child: Text(
                text,
                maxLines: maxLines,
                style: StylesManager.medium(fontSize: FontSize.medium),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServicesList extends StatelessWidget {
  const ServicesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * .18,
      width: context.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "الخدمات",
            style: StylesManager.bold(fontSize: FontSize.xlarge),
          ),
          Sizes.size10.heightSizedBox,
          Expanded(
              child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              PartnerCard(
                isDialog: false,
                serviceId: 1,
                name: "شريك اعمال",
                imagePath: "assets/images/business_partner.svg",
              ),
              PartnerCard(
                isDialog: false,
                serviceId: 2,
                name: "شريك رحلتي",
                imagePath: "assets/images/travel_partner.svg",
              ),
              PartnerCard(
                isDialog: false,
                serviceId: 3,
                name: "شريك ذبيحتي",
                imagePath: "assets/images/sake_partner.svg",
              ),
              PartnerCard(
                isDialog: false,
                serviceId: 4,
                name: "شريك سكني",
                imagePath: "assets/images/housing_partner.svg",
              ),
              PartnerCard(
                isDialog: false,
                serviceId: 5,
                name: "شراكات اخرى",
                imagePath: "assets/images/bubble.svg",
              ),
            ],
          )),
        ],
      ),
    );
  }
}

class PartnerCard extends StatelessWidget {
  const PartnerCard({
    Key? key,
    required this.name,
    required this.imagePath,
    required this.serviceId,
    required this.isDialog,
  }) : super(key: key);
  final String name;
  final String imagePath;
  final int serviceId;
  final bool isDialog;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.size8),
      child: GestureDetector(
        onTap: () {
          switch (serviceId) {
            case 1:
              isDialog == true
                  ? Get.to(
                      () => const AddBusinessPartnerAdsScreen(),
                      binding: BusinessPartnerBinding(),
                    )
                  : Get.toNamed(Routes.BUSINESS_PARTNER);
              break;
            case 2:
              isDialog == true
                  ? Get.to(() => const AddTripAdsScreen(),
                      binding: TravelPartnerBinding())
                  : Get.toNamed(Routes.TRAVEL_PARTNER);
              break;
            case 3:
              isDialog == true
                  ? Get.to(() => const AddSakeAdsScreen(),
                      binding: SakePartnerBinding())
                  : Get.toNamed(Routes.SAKE_PARTNER);

              break;
            case 4:
              isDialog == true
                  ? Get.to(
                      () => const AddHouseAdsScreen(),
                      binding: HousePartnerBinding(),
                    )
                  : Get.toNamed(Routes.HOUSE_PARTNER);

              break;

            default:
              isDialog == true
                  ? Get.to(
                      () => const AddOtherAdsScreen(),
                      binding: OtherServicePartnerBinding(),
                    )
                  : Get.toNamed(Routes.OTHER_SERVICE_PARTNER);
          }
        },
        child: Column(
          children: [
            Container(
              height: 80.h(context),
              width: 80.h(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: .5,
                  color: ColorsManager.veryLightGrey,
                ),
                color: const Color(
                  0xffF7F7F9,
                ),
              ),
              child: Center(
                child: SvgPicture.asset(imagePath),
              ),
            ),
            Sizes.size8.heightSizedBox,
            Text(
              name,
              style: StylesManager.semiBold(fontSize: FontSize.medium),
            )
          ],
        ),
      ),
    );
  }
}
