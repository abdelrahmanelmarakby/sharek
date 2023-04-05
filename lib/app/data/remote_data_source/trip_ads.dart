import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sharek/core/global/const.dart';
import 'package:sharek/core/services/network_service.dart/dio_network_service.dart';
import '../models/main_model.dart';
import '../models/trip_ads_item_model.dart';
import '../models/trip_ads_model.dart';

class TripPartnerAPI {
  static Future<TripAdvertisementsModel?> getTripAds() async {
    const request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: APIKeys.tripAds,
      data: NetworkRequestBody.empty(),
    );
    final response = await networkService.execute(
        request, (json) => TripAdvertisementsModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      orElse: () {},
    );
    return data;
  }

  static Future<TripAdsItemModel?> getTripAdsById(int id) async {
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: "${APIKeys.tripAds}/$id",
      data: const NetworkRequestBody.empty(),
    );
    final response = await networkService.execute(
        request, (json) => TripAdsItemModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      orElse: () {},
    );
    return data;
  }

  static Future<MainModel?> createTripComment({
    required int id,
    required String comment,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: "${APIKeys.createTripComment}/$id",
      data: NetworkRequestBody.fromData(
        FormData.fromMap(
          {
            "comment": comment,
          },
        ),
      ),
    );
    final response = await networkService.execute(
      request,
      (json) => MainModel.fromJson(json),
    );
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      orElse: () {},
    );
    return data;
  }

  static Future<TripAdvertisementsModel?> filterTripAds({
    int? servicesTypeid,
    String? startingPlace,
    int? numberPassengers,
    String? endingPlace,
    String? nationality,
    String? date,
    String? time,
    double? price,
    bool? withPackages,
    String? carType,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: APIKeys.tripAdsSearch,
      data: NetworkRequestBody.fromData(
        FormData.fromMap(
          {
            "service_type_id": servicesTypeid,
            "starting_place": startingPlace,
            "ending_place": endingPlace,
            "number_passengers": numberPassengers,
            "nationality": nationality,
            "date": date,
            "time": time,
            "price": price,
            "with_packages": withPackages == true ? 1 : 0,
            "car_type": carType,
          },
        ),
      ),
    );
    final response = await networkService.execute(
        request, (json) => TripAdvertisementsModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      orElse: () {},
    );
    return data;
  }

  static Future<MainModel?> createTripAds({
    int? servicesTypeid,
    String? startingPlace,
    int? numberPassengers,
    String? endingPlace,
    String? nationality,
    String? date,
    String? time,
    String? phone,
    List<File>? photos,
    double? price,
    bool? withPackages,
    String? carType,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: APIKeys.tripAds,
      data: NetworkRequestBody.fromData(
        FormData.fromMap(
          photos != null
              ? {
                  "service_type_id": servicesTypeid,
                  "starting_place": startingPlace,
                  "ending_place": endingPlace,
                  "number_passengers": numberPassengers,
                  "nationality": nationality,
                  "date": date,
                  "time": time,
                  "price": price,
                  "with_packages": withPackages == true ? 1 : 0,
                  "car_type": carType,
                  "phone": phone,
                  "photos[]": photos
                      .map(
                        (e) => MultipartFile.fromFileSync(
                          e.path,
                          filename: e.path.split('/').last,
                        ),
                      )
                      .toList(),
                }
              : {
                  "service_type_id": servicesTypeid,
                  "starting_place": startingPlace,
                  "ending_place": endingPlace,
                  "number_passengers": numberPassengers,
                  "nationality": nationality,
                  "date": date,
                  "time": time,
                  "price": price,
                  "with_packages": withPackages == true ? 1 : 0,
                  "car_type": carType,
                  "phone": phone,
                },
        ),
      ),
    );
    final response = await networkService.execute(
      request,
      (json) => MainModel.fromJson(json),
    );
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      orElse: () {
        return;
      },
    );
    return data;
  }
}
