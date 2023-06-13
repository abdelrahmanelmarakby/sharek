import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/app/modules/business_partner/views/business_partner_filter_result.dart';
import 'package:sharek/app/modules/travel_partner/widgets/services_type_item.dart';
import 'package:sharek/core/constants/theme/colors_manager.dart';
import 'package:sharek/core/constants/theme/font_manager.dart';
import 'package:sharek/core/constants/theme/styles_manager.dart';
import 'package:sharek/core/extensions/num.dart';
import 'package:sharek/core/widgets/progress_button.dart';

import '../../../../core/constants/theme/sizes_manager.dart';
import '../../../../core/widgets/custom_dropdown.dart';
import '../../../data/models/service_type.dart';
import '../../location_getter_widgets/controllers/location_getter_widgets_controller.dart';
import '../../location_getter_widgets/views/location_getter_widgets_view.dart';
import '../controllers/business_partner_controller.dart';

class BussinessPartnerFilterScreen extends GetView<BusinessPartnerController> {
  const BussinessPartnerFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تصفية'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: GetBuilder<BusinessPartnerController>(
                  builder: (controller) => Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            2,
                            (index) => Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: ServicesItem(
                                  activeIndex: controller.businessPartner ?? 0,
                                  index: businessServicesTypes[index]
                                          .serviceTypeId ??
                                      0,
                                  title:
                                      businessServicesTypes[index].name ?? "",
                                  onTap: () {
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
                                  activeIndex: controller.businessPartner ?? 0,
                                  index: businessServicesTypes[index + 2]
                                          .serviceTypeId ??
                                      0,
                                  title:
                                      businessServicesTypes[index + 2].name ??
                                          "",
                                  onTap: () {
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
                      const SizedBox(height: 12),
                      const LocationGetterWidgetsView(showDistrict: true),
                      const SizedBox(height: 12),
                      AppDropDown(
                        title: "النوع",
                        bottomSheet: SizedBox(
                          height: context.height * .5,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Sizes.size8
                                            .h(context)
                                            .heightSizedBox),
                                    IconButton.filled(
                                        onPressed: () {
                                          Get.close(1);
                                        },
                                        icon: const Icon(
                                          Icons.cancel,
                                          color: ColorsManager.primary,
                                          size: Sizes.size38,
                                        )),
                                  ],
                                ),
                                const Divider(
                                  color: ColorsManager.veryLightGrey,
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        // onTap: () => controller.selectRegionId(
                                        //     id: controller.searchRegions[index].id ??
                                        //         0,
                                        //     name: controller
                                        //             .searchRegions[index].name ??
                                        //         ""),
                                        child: Text("تجاري",
                                            style: StylesManager.bold(
                                                fontSize: FontSize.large)),
                                      ),
                                    ),
                                    const Divider(
                                      color: ColorsManager.veryLightGrey,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        // onTap: () => controller.selectRegionId(
                                        //     id: controller.searchRegions[index].id ??
                                        //         0,
                                        //     name: controller
                                        //             .searchRegions[index].name ??
                                        //         ""),
                                        child: Text("عقارى",
                                            style: StylesManager.bold(
                                                fontSize: FontSize.large)),
                                      ),
                                    ),
                                    const Divider(
                                      color: ColorsManager.veryLightGrey,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        // onTap: () => controller.selectRegionId(
                                        //     id: controller.searchRegions[index].id ??
                                        //         0,
                                        //     name: controller
                                        //             .searchRegions[index].name ??
                                        //         ""),
                                        child: Text("تقني",
                                            style: StylesManager.bold(
                                                fontSize: FontSize.large)),
                                      ),
                                    ),
                                    const Divider(
                                      color: ColorsManager.veryLightGrey,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        // onTap: () => controller.selectRegionId(
                                        //     id: controller.searchRegions[index].id ??
                                        //         0,
                                        //     name: controller
                                        //             .searchRegions[index].name ??
                                        //         ""),
                                        child: Text("أراضى",
                                            style: StylesManager.bold(
                                                fontSize: FontSize.large)),
                                      ),
                                    ),
                                    const Divider(
                                      color: ColorsManager.veryLightGrey,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        // onTap: () => controller.selectRegionId(
                                        //     id: controller.searchRegions[index].id ??
                                        //         0,
                                        //     name: controller
                                        //             .searchRegions[index].name ??
                                        //         ""),
                                        child: Text("اخرى",
                                            style: StylesManager.bold(
                                                fontSize: FontSize.large)),
                                      ),
                                    ),
                                    const Divider(
                                      color: ColorsManager.veryLightGrey,
                                    )
                                  ],
                                ),
                              ]),
                        ),
                        icon: const RotatedBox(
                          quarterTurns: 2,
                          child: Icon(Iconsax.category),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AppProgressButton(
              onPressed: (animationController) {
                Get.to(
                  () => BusinessAdsFilterResult(
                    servicesTypeid: controller.businessPartner,
                    location:
                        Get.find<LocationGetterWidgetsController>().regionName,
                    city: Get.find<LocationGetterWidgetsController>().cityName,
                  ),
                );
              },
              width: context.width,
              text: "تصفية",
            ),
          ],
        ),
      ),
    );
  }
}
