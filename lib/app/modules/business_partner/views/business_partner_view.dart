// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/app/data/models/business_ads_model.dart';
import 'package:sharek/app/data/models/home_model.dart';
import 'package:sharek/app/data/remote_data_source/business_ads.dart';
import 'package:sharek/app/modules/business_partner/bindings/business_partner_binding.dart';
import 'package:sharek/app/modules/business_partner/views/business_partner_details_screen.dart';
import 'package:sharek/app/modules/business_partner/views/bussiness_partner_filter_screen.dart';
import 'package:sharek/app/modules/home/views/home_view.dart';
import 'package:sharek/app/modules/travel_partner/widgets/services_type_item.dart';
import 'package:sharek/core/constants/theme/app_icons.dart';

import 'package:sharek/core/constants/theme/colors_manager.dart';
import 'package:sharek/core/constants/theme/font_manager.dart';
import 'package:sharek/core/constants/theme/styles_manager.dart';
import 'package:sharek/core/widgets/custom_text_field.dart';

import '../../../../core/widgets/app_text.dart';
import '../../../data/models/service_type.dart';
import '../controllers/business_partner_controller.dart';

class BusinessPartnerView extends GetView<BusinessPartnerController> {
  const BusinessPartnerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessPartnerController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('شريك أعمال'),
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
          child: FutureBuilder<BusinessPartnerModel?>(
            future: BusinessPartnerAPI.filterBusinessAds(
              servicesTypeid: controller.businessPartner,
              title: controller.textSearch,
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
                          prefixIcon: const Icon(SharekIcons.search_1),
                          onChange: controller.onChangedSearch,
                          controller: controller.searchController,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              Get.to(
                                () => const BussinessPartnerFilterScreen(),
                                binding: BusinessPartnerBinding(),
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
                            children: List.generate(
                              2,
                              (index) => Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: ServicesItem(
                                    activeIndex:
                                        controller.businessPartner ?? 0,
                                    index: businessServicesTypes[index]
                                            .serviceTypeId ??
                                        0,
                                    title:
                                        businessServicesTypes[index].name ?? "",
                                    onTap: () {
                                      if (controller.businessPartner ==
                                          businessServicesTypes[index]
                                              .serviceTypeId) {
                                        controller.changeBusinessPartnerState(
                                          null,
                                        );
                                        return;
                                      }

                                      controller.changeBusinessPartnerState(
                                        businessServicesTypes[index]
                                                .serviceTypeId ??
                                            0,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(height: 8),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              3,
                              (index) => Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: ServicesItem(
                                    activeIndex:
                                        controller.businessPartner ?? 0,
                                    index: businessServicesTypes[index + 2]
                                            .serviceTypeId ??
                                        0,
                                    title:
                                        businessServicesTypes[index + 2].name ??
                                            "",
                                    onTap: () {
                                      if (controller.businessPartner ==
                                          businessServicesTypes[index]
                                              .serviceTypeId) {
                                        controller.changeBusinessPartnerState(
                                          null,
                                        );
                                        return;
                                      }
                                      controller.changeBusinessPartnerState(
                                        businessServicesTypes[index + 2]
                                                .serviceTypeId ??
                                            0,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )),
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
                                        final ads = snapshot.data?.data?[index];
                                        return GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              () =>
                                                  BusinessPartnerDetailsScreen(
                                                adId: ads?.advertisementId ?? 0,
                                                isUserAds: false,
                                              ),
                                            );
                                          },
                                          child: AdCard(
                                            ad: NewAdvertisements(
                                              title: ads?.title,
                                              advertisementId:
                                                  ads?.advertisementId,
                                              createdAt1: ads?.createdAt1,
                                              createdAt2: ads?.createdAt2,
                                              userName: ads?.userName,
                                              location: ads?.location,
                                              neighborhood: ads?.neighborhood,
                                              photos: ads?.photos,
                                            ),
                                          ),
                                        );
                                      },
                                    )
                            ],
                          ),
                        )
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
    });
  }
}
