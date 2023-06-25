import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/app/modules/business_partner/views/business_partner_filter_result.dart';
import 'package:sharek/app/modules/travel_partner/widgets/services_type_item.dart';
import 'package:sharek/core/widgets/progress_button.dart';

import '../../../data/models/service_type.dart';
import '../../location_getter_widgets/controllers/location_getter_widgets_controller.dart';
import '../../location_getter_widgets/views/location_getter_widgets_view.dart';
import '../controllers/business_partner_controller.dart';
import '../widgets/type_drop_down.dart';

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
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: List.generate(
                          3,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ServicesItem(
                              activeIndex: controller.businessPartner ?? 0,
                              index:
                                  businessServicesTypes[index].serviceTypeId ??
                                      0,
                              title: index == 1
                                  ? "اعلانات البائعين"
                                  : businessServicesTypes[index].name ?? "",
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
                                  businessServicesTypes[index].serviceTypeId ??
                                      0,
                                );
                              },
                            ),
                          ),
                        )),
                      ),
                      const SizedBox(height: 12),
                      const LocationGetterWidgetsView(showDistrict: true),
                      const SizedBox(height: 12),
                      const TypeDropDown(),
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
                    type: controller.bussinessTypeModel?.id,
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
