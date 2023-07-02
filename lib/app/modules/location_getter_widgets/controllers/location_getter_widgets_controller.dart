import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:sharek/core/services/get_storage_helper.dart';

import '../../../data/remote_data_source/location_apis.dart';
import '../models/cities_model.dart';
import '../models/districts_model.dart';
import '../models/regions_model.dart';

class LocationGetterWidgetsController extends GetxController {
  late final Future<RegionsModel?> regions;
  DistrictsModel? districts;
  String? regionName = CacheHelper.getRegion?.name;
  String? districtName = CacheHelper.getDistrict?.name;
  int? regionId = CacheHelper.getRegion?.id;
  int? cityId = CacheHelper.getCity?.id;
  CitiesModel? cities;
  String? cityName = CacheHelper.getCity?.name;
  int? districtId = CacheHelper.getDistrict?.id;

  selectRegionId({required int id, required String name}) async {
    regionId = id;
    regionName = name;
    CacheHelper.cacheRegion(region: RegionModel(id: id, name: name));

    Get.close(1);
    BotToast.showLoading();
    try {
      (cities = await LocationApis.getCitiesById(id: regionId ?? 0));
    } catch (e) {
      log(e.toString());
    }

    BotToast.closeAllLoading();
    update();
  }

  selectCityId({required int id, required String name}) async {
    cityId = id;
    cityName = name;
    CacheHelper.cacheCity(city: CityModel(id: id, name: name));

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
    CacheHelper.cacheDistrict(district: DistrictModel(id: id, name: name));

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
  List<RegionModel> searchRegion(List<RegionModel> model, String text) {
    List<RegionModel> matchedList = [];

    if (text == "") {
      update();
      return model;
    }
    for (RegionModel? element in model) {
      if ((element?.name?.toLowerCase() ?? "").contains(text)) {
        matchedList.add(element!);
      }
    }
    update();
    return matchedList;
  }

  List<CityModel> searchCity(List<CityModel> model, String text) {
    List<CityModel> matchedList = [];
    if (text == "") {
      update();
      return model;
    }

    for (CityModel? element in model) {
      if ((element?.name?.toLowerCase() ?? "").contains(text)) {
        matchedList.add(element!);
      }
    }
    update();

    return matchedList;
  }

  List<DistrictModel> searchDistrict(List<DistrictModel> model, String text) {
    List<DistrictModel> matchedList = [];
    if (text == "") {
      update();
      return model;
    }

    for (DistrictModel? element in model) {
      if ((element?.name?.toLowerCase() ?? "").contains(text)) {
        matchedList.add(element!);
      }
    }
    update();

    return matchedList;
  }

  //=========================================================================
}