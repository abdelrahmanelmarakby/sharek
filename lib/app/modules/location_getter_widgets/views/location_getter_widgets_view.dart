import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/app/modules/location_getter_widgets/models/cities_model.dart';
import 'package:sharek/core/widgets/custom_dropdown.dart';

import '../../../../core/constants/theme/theme_export.dart';
import '../controllers/location_getter_widgets_controller.dart';
import '../models/districts_model.dart';
import '../models/regions_model.dart';

class LocationGetterWidgetsView
    extends GetView<LocationGetterWidgetsController> {
  const LocationGetterWidgetsView({
    Key? key,
    this.showDistrict = true,
  }) : super(key: key);
  final bool showDistrict;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<RegionsModel?>(
          future: controller.regions,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final RegionsModel regions = snapshot.data!;
              return GetBuilder<LocationGetterWidgetsController>(
                builder: (controller) => AppDropDown(
                  bottomSheet: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 30),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                            regions.data?.length ?? 0,
                            (index) => Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () => controller.selectRegionId(
                                            id: regions.data?[index].id ?? 0,
                                            name: regions.data?[index].name ??
                                                ""),
                                        child: Text(
                                            regions.data?[index].name ?? "",
                                            style: StylesManager.bold(
                                                fontSize: FontSize.large)),
                                      ),
                                    ),
                                    const Divider(
                                      color: ColorsManager.veryLightGrey,
                                    )
                                  ],
                                )),
                      ),
                    ),
                  ),
                  title: controller.regionName ?? "المنطقة",
                  center: false,
                  icon: const Icon(Iconsax.global),
                ),
              );
            } else if (snapshot.hasError) {
              return const Text("حدث خطأ ما ");
            }
            return const CircularProgressIndicator.adaptive();
          },
        ),
        const SizedBox(height: 12),
        GetBuilder<LocationGetterWidgetsController>(builder: (controller) {
          if (controller.regionId != null) {
            FutureBuilder<CitiesModel?>(
              future: controller.cities,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final CitiesModel cities = snapshot.data!;
                  return GetBuilder<LocationGetterWidgetsController>(
                    builder: (controller) => AppDropDown(
                      bottomSheet: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 30),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                                cities.data?.length ?? 0,
                                (index) => Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () =>
                                                controller.selectRegionId(
                                                    id: cities
                                                            .data?[index].id ??
                                                        0,
                                                    name: cities.data?[index]
                                                            .name ??
                                                        ""),
                                            child: Text(
                                                cities.data?[index].name ?? "",
                                                style: StylesManager.bold(
                                                    fontSize: FontSize.large)),
                                          ),
                                        ),
                                        const Divider(
                                          color: ColorsManager.veryLightGrey,
                                        )
                                      ],
                                    )),
                          ),
                        ),
                      ),
                      title: controller.cityName ?? "المدينة",
                      center: false,
                      icon: const Icon(Iconsax.global),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Text("حدث خطأ ما ");
                }
                return const CircularProgressIndicator.adaptive();
              },
            );
          }
          return const SizedBox();
        }),
        const SizedBox(height: 12),
        if (showDistrict && controller.cityId != null)
          FutureBuilder<DistrictsModel?>(
            future: controller.districts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final DistrictsModel districts = snapshot.data!;
                return GetBuilder<LocationGetterWidgetsController>(
                  builder: (controller) => AppDropDown(
                    bottomSheet: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 30),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                              districts.data?.length ?? 0,
                              (index) => Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () =>
                                              controller.selectRegionId(
                                                  id: districts
                                                          .data?[index].id ??
                                                      0,
                                                  name: districts
                                                          .data?[index].name ??
                                                      ""),
                                          child: Text(
                                              districts.data?[index].name ?? "",
                                              style: StylesManager.bold(
                                                  fontSize: FontSize.large)),
                                        ),
                                      ),
                                      const Divider(
                                        color: ColorsManager.veryLightGrey,
                                      )
                                    ],
                                  )),
                        ),
                      ),
                    ),
                    title: controller.districtName ?? "الحي",
                    center: false,
                    icon: const Icon(Iconsax.global),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Text("حدث خطأ ما ");
              }
              return const CircularProgressIndicator.adaptive();
            },
          ),
      ],
    );
  }
}
