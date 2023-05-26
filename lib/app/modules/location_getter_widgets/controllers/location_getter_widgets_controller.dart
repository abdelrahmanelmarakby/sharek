import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

import '../../../data/remote_data_source/location_apis.dart';
import '../models/cities_model.dart';
import '../models/districts_model.dart';
import '../models/regions_model.dart';

class LocationGetterWidgetsController extends GetxController {
  late final Future<RegionsModel?> regions;
  CitiesModel? cities;
  DistrictsModel? districts;
  String? regionName;
  String? cityName;
  String? districtName;
  int? regionId;
  int? cityId;
  int? districtId;
  selectRegionId({required int id, required String name}) async {
    regionId = id;
    regionName = name;
    Get.close(1);
    BotToast.showLoading();
    try {
      (cities = await LocationApis.getCitiesById(regionId ?? 0));
    } catch (e) {
      log(e.toString());
    }

    BotToast.closeAllLoading();
    update();
  }

  selectCityId({required int id, required String name}) async {
    cityId = id;
    cityName = name;
    Get.close(1);

    BotToast.showLoading();
    try {
      (districts = await LocationApis.getDistrictsById(cityId ?? 0));
    } catch (e) {
      log(e.toString());
    }

    BotToast.closeAllLoading();
    update();
  }

  selectDistricId({required int id, required String name}) {
    districtId = id;
    districtName = name;
    Get.close(1);
    update();
  }

  @override
  void onInit() {
    regions = LocationApis.getAllRegions();

    super.onInit();
  }
}
