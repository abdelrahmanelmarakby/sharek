import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/app/data/remote_data_source/home_apis.dart';
import 'package:sharek/app/modules/business_partner/bindings/business_partner_binding.dart';
import 'package:sharek/core/language/local_keys.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../data/models/home_search_model.dart';
import '../../business_partner/views/business_partner_details_screen.dart';
import '../../house_partner/bindings/house_partner_binding.dart';
import '../../house_partner/views/house_ads_details_screen.dart';
import '../../other_service_partner/bindings/other_service_partner_binding.dart';
import '../../other_service_partner/views/other_ads_details_screen.dart';
import '../../sake_partner/bindings/sake_partner_binding.dart';
import '../../sake_partner/views/sake_ads_details_screen.dart';
import '../../travel_partner/bindings/travel_partner_binding.dart';
import '../../travel_partner/views/travel_partner_details_screen.dart';
import '../controllers/home_controller.dart';
import 'home_view.dart';

class HomeSearchScreen extends GetView<HomeController> {
  const HomeSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text(LocalKeys.search.tr),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  name: LocalKeys.search,
                  hint: "أبحث هنا",
                  controller: controller.searchController,
                  onChange: controller.onChangedSearch,
                  prefixIcon: const Icon(Iconsax.search_normal),
                ),
                const SizedBox(height: 16),
                FutureBuilder<HomeSearchModel?>(
                  future: HomeAPI.searchHomeAds(
                    search: controller.homeSearch,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data?.data;
                      return data?.isNotEmpty ?? false
                          ? ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: data?.length ?? 0,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                var ad = data?[index];
                                return GestureDetector(
                                  onTap: () {
                                    if (ad?.serviceId == 1) {
                                      Get.to(
                                        () => BusinessPartnerDetailsScreen(
                                          adId: ad?.advertisementId ?? 0,
                                        ),
                                        binding: BusinessPartnerBinding(),
                                      );
                                    } else if (ad?.serviceId == 2) {
                                      Get.to(
                                        () => TravelPartnerDetailsScreen(
                                          id: ad?.advertisementId ?? 0,
                                        ),
                                        binding: TravelPartnerBinding(),
                                      );
                                    } else if (ad?.serviceId == 3) {
                                      Get.to(
                                        () => SakePartnerDetailsScreen(
                                          id: ad?.advertisementId ?? 0,
                                        ),
                                        binding: SakePartnerBinding(),
                                      );
                                    } else if (ad?.serviceId == 4) {
                                      Get.to(
                                        () => HousePartnerDetailsScreen(
                                          id: ad?.advertisementId ?? 0,
                                        ),
                                        binding: HousePartnerBinding(),
                                      );
                                    } else {
                                      Get.to(
                                        () => OtherPartnerDetailsScreen(
                                          id: ad?.advertisementId ?? 0,
                                        ),
                                        binding: OtherServicePartnerBinding(),
                                      );
                                    }
                                  },
                                  child: AdCard(ad: ad),
                                );
                              },
                            )
                          : Center(
                              child: AppText(
                                snapshot.data?.status == false
                                    ? ""
                                    : snapshot.data?.message ?? "",
                                color: Colors.black,
                              ),
                            );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(
                          valueColor:
                              AlwaysStoppedAnimation(ColorsManager.primary),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
