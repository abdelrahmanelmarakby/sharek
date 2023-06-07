// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/core/extensions/validator.dart';

import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/progress_button.dart';
import '../../../data/models/service_type.dart';
import '../../location_getter_widgets/controllers/location_getter_widgets_controller.dart';
import '../../location_getter_widgets/views/location_getter_widgets_view.dart';
import '../../travel_partner/widgets/services_type_item.dart';
import '../controllers/house_partner_controller.dart';
import 'house_filter_result_screen.dart';

class HouseAdsFiterScreen extends GetView<HousePartnerController> {
  const HouseAdsFiterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HousePartnerController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('تصفية'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: houseServicesTypes
                              .map(
                                (e) => Container(
                                  padding: EdgeInsets.only(
                                    left: controller.addHousePartner == 10
                                        ? 6
                                        : 0,
                                    right: controller.addHousePartner == 11
                                        ? 6
                                        : 0,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  child: ServicesItem(
                                    activeIndex: controller.addHousePartner,
                                    index: e.serviceTypeId ?? 0,
                                    title: e.name ?? "",
                                    onTap: () {
                                      controller.changeAddHousePartnerState(
                                        e.serviceTypeId ?? 0,
                                      );
                                    },
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 16),
                        const LocationGetterWidgetsView(showDistrict: true),
                        const SizedBox(height: 12),
                        controller.addHousePartner == 10
                            ? CustomTextField(
                                name: "",
                                hint: "عدد الشركاء (إختياري)",
                                borderRadius: 8,
                                controller: controller.filterNumberPartnersCtr,
                                type: TextInputType.text,
                                validate: Validator.validateEmpty,
                                prefixIcon: const Icon(
                                  Iconsax.people,
                                  color: Colors.black,
                                ),
                              )
                            : const SizedBox(),
                        controller.addHousePartner == 10
                            ? const SizedBox(height: 12)
                            : const SizedBox(),
                        controller.addHousePartner == 10
                            ? CustomTextField(
                                name: "",
                                hint: "الجنسية (إختياري)",
                                borderRadius: 8,
                                controller:
                                    controller.filterNationalityPartnersCtr,
                                type: TextInputType.text,
                                validate: Validator.validateEmpty,
                                prefixIcon: const Icon(
                                  Iconsax.global,
                                  color: Colors.black,
                                ),
                              )
                            : const SizedBox(),
                        controller.addHousePartner == 10
                            ? const SizedBox(height: 12)
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
                AppProgressButton(
                  width: context.width,
                  text: "تصفية",
                  onPressed: (animationController) {
                    Get.to(
                      () => HouseFilterResoult(
                        numberPartners: int.tryParse(
                          controller.filterNumberPartnersCtr.text,
                        ),
                        servicesTypeid: controller.addHousePartner,
                        location: Get.find<LocationGetterWidgetsController>()
                            .regionName,
                        neighborhood:
                            Get.find<LocationGetterWidgetsController>()
                                .cityName,
                        nationality:
                            controller.filterNationalityPartnersCtr.text,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
