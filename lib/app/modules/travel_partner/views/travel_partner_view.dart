import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sharek/app/data/remote_data_source/trip_ads.dart';
import 'package:sharek/app/modules/travel_partner/views/travel_partner_details_screen.dart';
import 'package:sharek/app/modules/travel_partner/views/trip_ads_filter.dart';
import 'package:sharek/core/constants/theme/app_icons.dart';
import 'package:sharek/core/constants/theme/sizes_manager.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/constants/theme/styles_manager.dart';
import '../../../../core/global/const.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_dropdown.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../data/models/service_type.dart';
import '../../../data/models/trip_ads_model.dart';
import '../bindings/travel_partner_binding.dart';
import '../controllers/travel_partner_controller.dart';
import '../widgets/trip_ads_item.dart';
import '../widgets/services_type_item.dart';

class TravelPartnerView extends GetView<TravelPartnerController> {
  const TravelPartnerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TravelPartnerController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('شريك رحلتي'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              ),
              onPressed: () {
                Get.back();
                controller.clearData();
              },
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () {
              return Get.forceAppUpdate();
            },
            child: FutureBuilder<TripAdvertisementsModel?>(
              future: TripPartnerAPI.filterTripAds(
                servicesTypeid: controller.travelPartner,
                title: controller.textSearch,
                date: controller.viewDate == null
                    ? null
                    : appDateFormate(controller.viewDate!, "en"),
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            name: "BusinessSearch",
                            hint: "ابحث هنا",
                            onChange: controller.onChangedSearch,
                            prefixIcon: const Icon(SharekIcons.search_1),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => const TripAdsFilter(),
                                  binding: TravelPartnerBinding(),
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
                            children: tripServicesTypes
                                .map(
                                  (e) => Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: ServicesItem(
                                        activeIndex:
                                            controller.travelPartner ?? 0,
                                        index: e.serviceTypeId ?? 0,
                                        title: e.name ?? "",
                                        onTap: () {
                                          if (controller.travelPartner ==
                                              e.serviceTypeId) {
                                            controller.changeTravelPartnerState(
                                              null,
                                            );
                                            return;
                                          }
                                          controller.travelPartner == null
                                              ? controller
                                                  .changeTravelPartnerState(
                                                  e.serviceTypeId ?? 0,
                                                )
                                              : controller.travelPartner = null;
                                        },
                                      ),
                                    ),
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
                                  title: "بداية الرحلة",
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
                                  title: controller.viewDate == null
                                      ? "التاريخ"
                                      : appDateFormate(
                                          controller.viewDate!, "ar"),
                                  center: true,
                                  bottomSheet: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.date,
                                    dateOrder: DatePickerDateOrder.ymd,
                                    minimumDate: DateTime.now(),
                                    initialDateTime: DateTime.now(),
                                    onDateTimeChanged:
                                        controller.onDateViewPickerChanged,
                                  ),
                                ),
                              ),
                            ],
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
                                snapshot.data?.data?.isEmpty ?? false
                                    ? Center(
                                        child: AppText(
                                          snapshot.data?.message ?? "",
                                          color: Colors.black,
                                        ),
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
                                          final ads =
                                              snapshot.data?.data?[index];
                                          return snapshot
                                                      .data?.data?.isNotEmpty ??
                                                  false
                                              ? GestureDetector(
                                                  onTap: () {
                                                    Get.to(
                                                      () =>
                                                          TravelPartnerDetailsScreen(
                                                        id: ads?.advertisementId ??
                                                            0,
                                                        isUserAds: false,
                                                      ),
                                                    );
                                                  },
                                                  child: TripAdsItem(
                                                    ad: ads,
                                                  ),
                                                )
                                              : Center(
                                                  child: AppText(
                                                    snapshot.data?.message ??
                                                        "",
                                                    color: Colors.black,
                                                  ),
                                                );
                                        },
                                      )
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
