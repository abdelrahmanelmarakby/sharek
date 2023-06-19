import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/app/data/remote_data_source/profile_apis.dart';
import 'package:sharek/core/extensions/export.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/sizes_manager.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../data/models/favorites_model.dart';
import '../../business_partner/bindings/business_partner_binding.dart';
import '../../business_partner/views/business_partner_details_screen.dart';
import '../../home/views/home_view.dart';
import '../../house_partner/bindings/house_partner_binding.dart';
import '../../house_partner/views/house_ads_details_screen.dart';
import '../../other_service_partner/bindings/other_service_partner_binding.dart';
import '../../other_service_partner/views/other_ads_details_screen.dart';
import '../../sake_partner/bindings/sake_partner_binding.dart';
import '../../sake_partner/views/sake_ads_details_screen.dart';
import '../../travel_partner/bindings/travel_partner_binding.dart';
import '../../travel_partner/views/travel_partner_details_screen.dart';
import '../controllers/profile_controller.dart';
import '../widgets/dismissible_background.dart';

class FavoritesScreen extends GetView<ProfileController> {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المفضلة'),
      ),
      body: FutureBuilder<FavoritesModel?>(
        future: ProfileApis.getUserFavorites(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data?.data;
            if (data?.isEmpty ?? false) {
              return const Center(
                child: AppText(
                  "لا يوجد اعلانات في المفضلة",
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              );
            } else {
              return ListView.separated(
                itemCount: data?.length ?? 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                separatorBuilder: (context, index) =>
                    Sizes.size8.h(context).heightSizedBox,
                itemBuilder: (context, index) {
                  var ad = data?[index];
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.startToEnd,
                    background: const DismissibleBackground(),
                    onDismissed: (_) => {
                      controller.addToFavorites(id: ad?.advertisementId ?? 0),
                    },
                    child: GestureDetector(
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
                    ),
                  );
                },
              );
            }
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
      ),
    );
  }
}
