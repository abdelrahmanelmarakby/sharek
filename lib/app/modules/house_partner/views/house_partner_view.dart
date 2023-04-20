import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sharek/app/data/remote_data_source/house_ads_apis.dart';
import 'package:sharek/app/modules/house_partner/bindings/house_partner_binding.dart';

import '../../../../core/constants/theme/app_icons.dart';
import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/constants/theme/styles_manager.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../data/models/house_partners_model.dart';
import '../../../data/models/service_type.dart';
import '../../travel_partner/widgets/services_type_item.dart';
import '../controllers/house_partner_controller.dart';
import '../widgets/house_ads.dart';
import 'house_ads_details_screen.dart';
import 'house_ads_filter.dart';

class HousePartnerView extends GetView<HousePartnerController> {
  const HousePartnerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HousePartnerController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('شريك سكني'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              ),
              onPressed: () {
                Get.back();
                // controller.clearData();
              },
            ),
          ),
          body: FutureBuilder<HousePartnersModel?>(
            future: HousePartnerAPI.filterHouseAds(
              servicesTypeid: controller.housePartner,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        CustomTextField(
                          name: "BusinessSearch",
                          hint: "ابحث هنا",
                          prefixIcon: const Icon(SharekIcons.search_1),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              Get.to(
                                () => const HouseAdsFiterScreen(),
                                binding: HousePartnerBinding(),
                              );
                            },
                            child: const Icon(
                              SharekIcons.filter_3,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: houseServicesTypes
                              .map(
                                (e) => Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: ServicesItem(
                                      activeIndex: controller.housePartner ?? 0,
                                      index: e.serviceTypeId ?? 0,
                                      title: e.name ?? "",
                                      onTap: () {
                                        controller.changeHousePartnerState(
                                          e.serviceTypeId ?? 0,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: context.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "الاعلانات الجديدة",
                                style: StylesManager.bold(
                                    fontSize: FontSize.xlarge),
                              ),
                              const SizedBox(height: 8),
                              controller.housePartner == 0
                                  ? ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          snapshot.data?.data?.length ?? 0,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(height: 8),
                                      itemBuilder: (context, index) {
                                        Data? ads = snapshot.data?.data?[index];
                                        return snapshot
                                                    .data?.data?.isNotEmpty ??
                                                false
                                            ? GestureDetector(
                                                onTap: () {
                                                  Get.to(
                                                    () =>
                                                        HousePartnerDetailsScreen(
                                                      id: ads?.advertisementId ??
                                                          0,
                                                    ),
                                                  );
                                                },
                                                child: HouseAdsItem(
                                                  ad: ads,
                                                ),
                                              )
                                            : Center(
                                                child: AppText(
                                                  snapshot.data?.message ?? "",
                                                  color: Colors.black,
                                                ),
                                              );
                                      },
                                    )
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          snapshot.data?.data?.length ?? 0,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(height: 8),
                                      itemBuilder: (context, index) {
                                        final ads = snapshot.data?.data?[index];
                                        return snapshot
                                                    .data?.data?.isNotEmpty ??
                                                false
                                            ? GestureDetector(
                                                onTap: () {
                                                  Get.to(
                                                    () =>
                                                        HousePartnerDetailsScreen(
                                                      id: ads?.advertisementId ??
                                                          0,
                                                    ),
                                                  );
                                                },
                                                child: HouseAdsItem(
                                                  ad: ads,
                                                ),
                                              )
                                            : Center(
                                                child: AppText(
                                                  snapshot.data?.message ?? "",
                                                  color: Colors.black,
                                                ),
                                              );
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
      },
    );
  }
}
