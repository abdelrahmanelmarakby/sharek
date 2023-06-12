import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

import '../../../data/remote_data_source/location_apis.dart';
import '../models/cities_model.dart';
import '../models/districts_model.dart';
import '../models/regions_model.dart';

class LocationGetterWidgetsController extends GetxController {
  late final Future<RegionsModel?> regions;
  List cityNames = [];
  List districtNames = [];
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

  //==========================  Search Variables ========================

  List<RegionModel> searchRegions = [];
  List<CityModel> searchCities = [];
  List<DistrictModel> searchDistricts = [];

  //==========================  Search Methods =============================
  List<RegionModel> searchRegion(RegionsModel model, String text) {
    List<RegionModel> matchedList = [];

    if (text == "") {
      update();
      return model.data!;
    }
    for (RegionModel? element in model.data!) {
      if ((element?.name?.toLowerCase() ?? "").contains(text)) {
        matchedList.add(element!);
      }
    }
    print(matchedList);

    update();
    return matchedList;
  }

  List<CityModel> searchCity(CitiesModel model, String text) {
    List<CityModel> matchedList = [];
    if (text == "") {
      update();
      return model.data!;
    }

    for (CityModel? element in model.data!) {
      if ((element?.name?.toLowerCase() ?? "").contains(text)) {
        matchedList.add(element!);
      }
    }
    print(matchedList);
    update();

    return matchedList;
  }

  List<DistrictModel> searchDistrict(DistrictsModel model, String text) {
    List<DistrictModel> matchedList = [];
    if (text == "") {
      update();
      return model.data!;
    }

    for (DistrictModel? element in model.data!) {
      if ((element?.name?.toLowerCase() ?? "").contains(text)) {
        matchedList.add(element!);
      }
    }
    print(matchedList);
    update();

    return matchedList;
  }
}
