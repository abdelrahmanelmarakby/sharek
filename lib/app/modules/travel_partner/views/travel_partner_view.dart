import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/app/data/remote_data_source/trip_ads.dart';
import 'package:sharek/app/modules/travel_partner/views/travel_partner_details_screen.dart';
import 'package:sharek/app/modules/travel_partner/views/trip_ads_filter.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/constants/theme/styles_manager.dart';
import '../../../../core/widgets/custom_dropdown.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../data/models/trip_ads_model.dart';
import '../../../data/models/trip_services_type_model.dart';
import '../bindings/travel_partner_binding.dart';
import '../controllers/travel_partner_controller.dart';
import '../widgets/trip_ads_item.dart';
import '../widgets/trip_services_type_item.dart';

class TravelPartnerView extends GetView<TravelPartnerController> {
  const TravelPartnerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TravelPartnerController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('شريك رحلتي'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
              controller.clearData();
            },
          ),
        ),
        body: FutureBuilder<TripAdvertisementsModel?>(
          future: TripPartnerAPI.filterTripAds(
            servicesTypeid: controller.travelPartner,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      name: "BusinessSearch",
                      hint: "ابحث هنا",
                      prefixIcon: const Icon(Iconsax.search_normal),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          Get.to(
                            () => const TripAdsFilter(),
                            binding: TravelPartnerBinding(),
                          );
                        },
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
                              activeIndex: controller.travelPartner ?? 0,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AppDropDown(
                            title: "نهاية الرحلة",
                            center: true,
                            bottomSheet: Container(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: AppDropDown(
                            title: "نهاية الرحلة",
                            center: true,
                            bottomSheet: Container(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: AppDropDown(
                            title: "التاريخ",
                            center: true,
                            bottomSheet: CupertinoTimerPicker(
                              mode: CupertinoTimerPickerMode.hms,
                              minuteInterval: 1,
                              secondInterval: 1,
                              initialTimerDuration: controller.initialTimer,
                              onTimerDurationChanged:
                                  controller.onTimerDurationChanged,
                            ),
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
                                    Get.to(
                                      () => TravelPartnerDetailsScreen(
                                        id: ads?.advertisementId ?? 0,
                                      ),
                                    );
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
                                    Get.to(
                                      () => TravelPartnerDetailsScreen(
                                        id: ads?.advertisementId ?? 0,
                                      ),
                                    );
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
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
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
    });
  }
}
