import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/app/modules/travel_partner/views/travel_partner_details_screen.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/constants/theme/styles_manager.dart';
import '../../../../core/widgets/app_expansion_tile.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../data/models/trip_ads_model.dart';
import '../../../data/models/trip_services_type_model.dart';
import '../controllers/travel_partner_controller.dart';
import '../widgets/trip_ads_item.dart';
import '../widgets/trip_services_type_item.dart';

class TravelPartnerView extends GetView<TravelPartnerController> {
  const TravelPartnerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TravelPartnerController>(builder: (controller) {
      return FutureBuilder<TripAdvertisementsModel?>(
        future: controller.getTripAds,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('شريك رحلتي'),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      name: "BusinessSearch",
                      hint: "ابحث هنا",
                      prefixIcon: const Icon(Iconsax.search_normal),
                      suffixIcon: GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Iconsax.filter,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: tripServicesTypes
                          .map(
                            (e) => TripServicesItem(
                              activeIndex: controller.travelPartner,
                              index: e.serviceTypeId ?? 0,
                              title: e.name ?? "",
                              onTap: () {
                                controller.changeTravelPartnerState(
                                  e.serviceTypeId ?? 0,
                                );
                              },
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: const [
                        Expanded(
                          child: AppExpansionTile(
                            title: "بداية الرحلة",
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: AppExpansionTile(
                            title: "نهاية الرحلة",
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: CustomTextField(
                            name: "",
                            hint: "ساعة الرحلة",
                            borderRadius: 8,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "الاعلانات الجديدة",
                      style: StylesManager.bold(fontSize: FontSize.xlarge),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: controller.travelPartner == 0
                          ? ListView.separated(
                              itemCount: snapshot.data?.data?.length ?? 0,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 8),
                              itemBuilder: (context, index) {
                                final ads = snapshot.data?.data?[index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => TravelPartnerDetailsScreen(
                                          ads: ads,
                                        ));
                                  },
                                  child: TripAdsItem(
                                    ad: ads,
                                  ),
                                );
                              },
                            )
                          : ListView.separated(
                              itemCount: snapshot.data?.data?.length ?? 0,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 8),
                              itemBuilder: (context, index) {
                                final ads = snapshot.data?.data?[index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => TravelPartnerDetailsScreen(
                                          ads: ads,
                                        ));
                                  },
                                  child: TripAdsItem(
                                    ad: ads,
                                  ),
                                );
                              },
                            ),
                    ),
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
      );
    });
  }
}
