import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sharek/app/data/models/business_ad_model.dart';
import 'package:sharek/app/data/models/business_ads_model.dart';
import 'package:sharek/app/data/models/main_model.dart';
import 'package:sharek/app/data/models/trip_ads_model.dart';
import 'package:sharek/core/global/const.dart';
import 'package:sharek/core/services/network_service.dart/dio_network_service.dart';

class BusinessPartnerAPI {
  static Future<BusinessPartnerModel?> getBusinessAds() async {
    const request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: APIKeys.businessAds,
      data: NetworkRequestBody.empty(),
    );
    final response = await networkService.execute(
        request, (json) => BusinessPartnerModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      orElse: () {},
    );
    return data;
  }

  static Future<BusinessPartnerAdModel?> getBusinessAdById(int id) async {
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: "${APIKeys.businessAds}/$id",
      data: const NetworkRequestBody.empty(),
    );
    final response = await networkService.execute(
        request, (json) => BusinessPartnerAdModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      orElse: () {},
    );
    return data;
  }

  static Future<MainModel?> createBusinessComment({
    required int id,
    required String comment,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: "${APIKeys.createBusinessAdComment}/$id",
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

  static Future<TripAdvertisementsModel?> filterTripAds(
      {int? servicesTypeid, String? location, String? city}) async {
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: APIKeys.businessAdsSearch,
      data: NetworkRequestBody.fromData(
        FormData.fromMap(
          {
            "service_type_id": servicesTypeid,
            "location": location,
            "neighborhood": location,
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
      path: APIKeys.businessAds,
      data: NetworkRequestBody.fromData(
        FormData.fromMap(
          photos != null
              ? {
                  "service_type_id": servicesTypeid,
                  "location": startingPlace,
                  "neighborhood": endingPlace,
                  "title": numberPassengers,
                  "description": nationality,
                  "phone": date,
                  "time": time,
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
                  "location": startingPlace,
                  "neighborhood": endingPlace,
                  "title": numberPassengers,
                  "description": nationality,
                  "phone": date,
                  "time": time,
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
