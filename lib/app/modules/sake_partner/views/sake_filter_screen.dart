import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/app/modules/sake_partner/bindings/sake_partner_binding.dart';
import 'package:sharek/app/modules/sake_partner/views/sake_filter_result.dart';

import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/progress_button.dart';
import '../../../data/models/service_type.dart';
import '../../location_getter_widgets/controllers/location_getter_widgets_controller.dart';
import '../../location_getter_widgets/views/location_getter_widgets_view.dart';
import '../../travel_partner/widgets/services_type_item.dart';
import '../controllers/sake_partner_controller.dart';

class SakeFilterScreen extends GetView<SakePartnerController> {
  const SakeFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SakePartnerController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('تصفية'),
            leading: IconButton(
              icon: Icon(
                Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              ),
              onPressed: () {
                Get.back();
                controller.clearFilterData();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                        controller.filterSacrificePartner,
                                    index: e.serviceTypeId ?? 0,
                                    title: e.name ?? "",
                                    onTap: () {
                                      controller
                                          .changeFilterSacrificePartnerState(
                                        e.serviceTypeId ?? 0,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 16),
                      const LocationGetterWidgetsView(),
                      const SizedBox(height: 12),
                      const AppText(
                        "أختر نوع الذبيحة",
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeights.semiBold,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: controller.filterSacrificeType
                            .map(
                              (e) => Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  child: ServicesItem(
                                    activeIndex: controller
                                            .filterSacrificeTypeItem
                                            ?.serviceTypeId ??
                                        0,
                                    index: e.serviceTypeId ?? 0,
                                    title: e.name ?? "",
                                    onTap: () {
                                      controller
                                          .changeFilterSacrificeTypeState(e);
                                    },
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      controller.filterSacrificePartner == 8
                          ? const SizedBox()
                          : const SizedBox(height: 12),
                      controller.filterSacrificePartner == 8
                          ? const SizedBox()
                          : const AppText(
                              "أختر الكمية",
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeights.semiBold,
                            ),
                      controller.filterSacrificePartner == 8
                          ? const SizedBox()
                          : const SizedBox(height: 12),
                      controller.filterSacrificePartner == 8
                          ? const SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: controller.filterQuantityType
                                  .map(
                                    (e) => Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        child: ServicesItem(
                                          activeIndex: controller
                                                  .filterQuantityItem
                                                  ?.serviceTypeId ??
                                              0,
                                          index: e.serviceTypeId ?? 0,
                                          title: e.name ?? "",
                                          onTap: () {
                                            controller
                                                .changefilterQuantityTypeState(
                                              e,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: AppProgressButton(
                    onPressed: (animationController) {
                      Get.to(
                        () => SakeFilterResultScreen(
                          location: Get.find<LocationGetterWidgetsController>()
                              .regionName,
                          neighborhood:
                              Get.find<LocationGetterWidgetsController>()
                                  .cityName,
                          quantity: controller.filterSacrificePartner == 8
                              ? null
                              : controller.filterQuantityItem?.name ?? "",
                          sacrificeType:
                              controller.filterSacrificeTypeItem?.name ?? "",
                          servicesTypeid: controller.filterSacrificePartner,
                        ),
                        binding: SakePartnerBinding(),
                      );
                    },
                    width: context.width,
                    text: "تصفية",
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
