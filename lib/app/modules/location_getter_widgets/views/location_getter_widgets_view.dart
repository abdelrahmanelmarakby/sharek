import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/app/modules/location_getter_widgets/models/cities_model.dart';
import 'package:sharek/core/constants/theme/sizes_manager.dart';
import 'package:sharek/core/extensions/num.dart';
import 'package:sharek/core/widgets/custom_dropdown.dart';

import '../../../../core/constants/theme/theme_export.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../data/remote_data_source/location_apis.dart';
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
              final List<RegionModel> regions = snapshot.data?.data ?? [];
              if (controller.searchRegions.isEmpty) {
                controller.searchRegions = regions;
              }
              return GetBuilder<LocationGetterWidgetsController>(
                builder: (controller) => AppDropDown(
                  bottomSheet: Container(
                    height: context.height * .5,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 25),
                    child: SingleChildScrollView(
                      child: GetBuilder<LocationGetterWidgetsController>(
                        builder: (controller) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomTextField(
                                hint: "ابحث هنا ",
                                height: 40.h(context),
                                onChange: (value) {
                                  controller.searchRegions =
                                      controller.searchRegion(regions, value);
                                },
                                suffixIcon: const Icon(Iconsax.search_normal),
                              ),
                              Sizes.size18.h(context).heightSizedBox,
                              const Divider(
                                color: ColorsManager.veryLightGrey,
                              ),
                              ...List.generate(
                                  controller.searchRegions.length,
                                  (index) => Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () =>
                                                  controller.selectRegionId(
                                                      id: controller
                                                              .searchRegions[
                                                                  index]
                                                              .id ??
                                                          0,
                                                      name: controller
                                                              .searchRegions[
                                                                  index]
                                                              .name ??
                                                          ""),
                                              child: Text(
                                                  controller
                                                          .searchRegions[index]
                                                          .name ??
                                                      "",
                                                  style: StylesManager.bold(
                                                      fontSize:
                                                          FontSize.large)),
                                            ),
                                          ),
                                          const Divider(
                                            color: ColorsManager.veryLightGrey,
                                          )
                                        ],
                                      )),
                            ]),
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
        GetBuilder<LocationGetterWidgetsController>(builder: (controller) {
          if (controller.regionId == null) return const SizedBox();
          return FutureBuilder<CitiesModel?>(
            future: LocationApis.getCitiesById(controller.regionId!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<CityModel> cities = snapshot.data?.data ?? [];
                if (controller.searchCities.isEmpty) {
                  controller.searchCities = cities;
                }
                return Column(
                  children: [
                    const SizedBox(height: 12),
                    AppDropDown(
                      bottomSheet: Container(
                        height: context.height * .5,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 25),
                        child: SingleChildScrollView(
                          child: GetBuilder<LocationGetterWidgetsController>(
                            builder: (controller) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomTextField(
                                    hint: "ابحث هنا ",
                                    height: 40.h(context),
                                    onChange: (value) {
                                      controller.searchCities =
                                          controller.searchCity(cities, value);
                                    },
                                    suffixIcon:
                                        const Icon(Iconsax.search_normal),
                                  ),
                                  Sizes.size18.h(context).heightSizedBox,
                                  const Divider(
                                    color: ColorsManager.veryLightGrey,
                                  ),
                                  ...List.generate(
                                      controller.searchCities.length,
                                      (index) => Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      controller.selectCityId(
                                                          id: controller
                                                                  .searchCities[
                                                                      index]
                                                                  .id ??
                                                              0,
                                                          name: controller
                                                                  .searchCities[
                                                                      index]
                                                                  .name ??
                                                              ""),
                                                  child: Text(
                                                      controller
                                                              .searchCities[
                                                                  index]
                                                              .name ??
                                                          "",
                                                      style: StylesManager.bold(
                                                          fontSize:
                                                              FontSize.large)),
                                                ),
                                              ),
                                              const Divider(
                                                color:
                                                    ColorsManager.veryLightGrey,
                                              )
                                            ],
                                          )),
                                ]),
                          ),
                        ),
                      ),
                      title: controller.cityName ?? "المدينة",
                      center: false,
                      icon: const Icon(Iconsax.global),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                Get.log(snapshot.error.toString());
                return Text("حدث خطأ ما المدينة ${snapshot.error.toString()}");
              }
              return const CircularProgressIndicator.adaptive();
            },
          );
        }),
        GetBuilder<LocationGetterWidgetsController>(
          builder: (controller) {
            if (controller.cityId == null) return const SizedBox();
            if (showDistrict && controller.cityId != null) {
              return FutureBuilder<DistrictsModel?>(
                future: LocationApis.getDistrictsById(controller.cityId!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<DistrictModel> districts =
                        snapshot.data?.data ?? [];
                    if (controller.searchDistricts.isEmpty) {
                      controller.searchDistricts = districts;
                    }

                    return Column(
                      children: [
                        const SizedBox(height: 12),
                        AppDropDown(
                          bottomSheet: Container(
                            height: context.height * .5,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 25),
                            child: SingleChildScrollView(
                              child:
                                  GetBuilder<LocationGetterWidgetsController>(
                                builder: (controller) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomTextField(
                                        hint: "ابحث هنا ",
                                        height: 40.h(context),
                                        onChange: (value) {
                                          controller.searchDistricts =
                                              controller.searchDistrict(
                                                  districts, value);
                                        },
                                        suffixIcon:
                                            const Icon(Iconsax.search_normal),
                                      ),
                                      Sizes.size18.h(context).heightSizedBox,
                                      const Divider(
                                        color: ColorsManager.veryLightGrey,
                                      ),
                                      ...List.generate(
                                          controller.searchDistricts.length,
                                          (index) => Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: GestureDetector(
                                                      onTap: () => controller
                                                          .selectDistricId(
                                                              id: controller
                                                                      .searchDistricts[
                                                                          index]
                                                                      .id ??
                                                                  0,
                                                              name: controller
                                                                      .searchDistricts[
                                                                          index]
                                                                      .name ??
                                                                  ""),
                                                      child: Text(
                                                          controller
                                                                  .searchDistricts[
                                                                      index]
                                                                  .name ??
                                                              "",
                                                          style: StylesManager
                                                              .bold(
                                                                  fontSize:
                                                                      FontSize
                                                                          .large)),
                                                    ),
                                                  ),
                                                  const Divider(
                                                    color: ColorsManager
                                                        .veryLightGrey,
                                                  )
                                                ],
                                              )),
                                    ]),
                              ),
                            ),
                          ),
                          title: controller.districtName ?? "الحي",
                          center: false,
                          icon: const Icon(Iconsax.global),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Text("حدث خطأ ما ");
                  }
                  return const CircularProgressIndicator.adaptive();
                },
              );
            }
            return const SizedBox();
          },
        )
      ],
    );
  }
}
