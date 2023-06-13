import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sharek/app/modules/sake_partner/bindings/sake_partner_binding.dart';
import 'package:sharek/app/modules/sake_partner/views/sake_ads_details_screen.dart';
import 'package:sharek/app/modules/sake_partner/views/sake_filter_screen.dart';

import '../../../../core/constants/theme/app_icons.dart';
import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/constants/theme/sizes_manager.dart';
import '../../../../core/constants/theme/styles_manager.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../data/models/sarifice_ads_model.dart';
import '../../../data/models/service_type.dart';
import '../../../data/remote_data_source/serifice_apis.dart';
import '../../travel_partner/widgets/services_type_item.dart';
import '../controllers/sake_partner_controller.dart';
import '../widgets/sake_item.dart';

class SakePartnerView extends GetView<SakePartnerController> {
  const SakePartnerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SakePartnerController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('شريك ذبيحتي'),
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
          body: RefreshIndicator(
            onRefresh: () {
              return Get.forceAppUpdate();
            },
            child: FutureBuilder<SarificeAdsModel?>(
              future: SarificeAPIS.filterSerificeAds(
                servicesTypeid: controller.sacrificePartner,
                sacrificeType: controller.sacrificeTypeItem?.name,
                title: controller.textSearch,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data?.data;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          CustomTextField(
                            name: "BusinessSearch",
                            hint: "ابحث هنا",
                            prefixIcon: const Icon(SharekIcons.search_1),
                            controller: controller.searchController,
                            onChange: controller.onChangedSearch,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => const SakeFilterScreen(),
                                  binding: SakePartnerBinding(),
                                );
                              },
                              child: const Icon(
                                SharekIcons.filter_3,
                                size: Sizes.size26,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: sacrificeServicesTypes
                                .map(
                                  (e) => Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      child: ServicesItem(
                                        activeIndex:
                                            controller.sacrificePartner ?? 0,
                                        index: e.serviceTypeId ?? 0,
                                        title: e.name == "اعلان بيع"
                                            ? "اعلانات البائعين"
                                            : e.name ?? "",
                                        onTap: () {
                                          if (controller.sacrificePartner ==
                                              e.serviceTypeId) {
                                            controller
                                                .changeSacrificePartnerState(
                                              null,
                                            );
                                            return;
                                          }
                                          controller
                                              .changeSacrificePartnerState(
                                            e.serviceTypeId ?? 0,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: controller.sacrificeType
                                .map(
                                  (e) => Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      child: ServicesItem(
                                        activeIndex: controller
                                                .sacrificeTypeItem
                                                ?.serviceTypeId ??
                                            0,
                                        index: e.serviceTypeId ?? 0,
                                        title: e.name ?? "",
                                        onTap: () {
                                          if (controller.sacrificeTypeItem ==
                                              e) {
                                            controller.changeSacrificeTypeState(
                                              null,
                                            );
                                            return;
                                          }
                                          controller.changeSacrificeTypeState(
                                            e,
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
                                    fontSize: FontSize.xlarge,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                data?.isNotEmpty ?? false
                                    ? ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            snapshot.data?.data?.length ?? 0,
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(height: 8),
                                        itemBuilder: (context, index) {
                                          Data? ads =
                                              snapshot.data?.data?[index];
                                          return GestureDetector(
                                            onTap: () {
                                              Get.to(
                                                () => SakePartnerDetailsScreen(
                                                  id: ads?.advertisementId ?? 0,
                                                  isUserAds: false,
                                                ),
                                              );
                                            },
                                            child: SakeAdsItem(
                                              ad: ads,
                                            ),
                                          );
                                        },
                                      )
                                    : Center(
                                        child: AppText(
                                          snapshot.data?.message ?? "",
                                          color: Colors.black,
                                        ),
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
          ),
        );
      },
    );
  }
}
