import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sharek/core/global/const.dart';
import 'package:sharek/core/services/network_service.dart/dio_network_service.dart';
import '../../../core/services/shared_prefs.dart';
import '../models/main_model.dart';
import '../models/trip_ads_item_model.dart';
import '../models/trip_ads_model.dart';

class TripPartnerAPI {
  static Future<TripAdvertisementsModel?> getTripAds() async {
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: APIKeys.tripAds,
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: const NetworkRequestBody.empty(),
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
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: const NetworkRequestBody.empty(),
    );
    final response = await networkService.execute(
        request, (json) => TripAdsItemModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      orElse: () {},
      badRequest: (data) {
        return data;
      },
      conflict: (data) {
        return data;
      },
      invalidParameters: (data) {
        return data;
      },
      noAccess: (data) {
        return data;
      },
      noData: (data) {
        return data;
      },
      notFound: (data) {
        return data;
      },
      unProcessable: (data) {
        return data;
      },
    );
    return data;
  }

  static Future<MainModel?> createTripComment({
    required int id,
    required String comment,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
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
      badRequest: (data) {
        return data;
      },
      conflict: (data) {
        return data;
      },
      invalidParameters: (data) {
        return data;
      },
      noAccess: (data) {
        return data;
      },
      noData: (data) {
        return data;
      },
      notFound: (data) {
        return data;
      },
      unProcessable: (data) {
        return data;
      },
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
    String? title,
    String? district,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: APIKeys.tripAds,
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: const NetworkRequestBody.empty(),
      queryParams: {
        if (servicesTypeid != null) "service_type_id": servicesTypeid,
        if (startingPlace != null) "starting_place": startingPlace,
        if (endingPlace != null) "ending_place": endingPlace,
        if (numberPassengers != null) "number_passengers": numberPassengers,
        if (nationality != null) "nationality": nationality,
        if (date != null) "date": date,
        if (title != null) "title": title,
        if (time != null) "time": time,
        if (price != null) "price": price,
        if (withPackages != null) "with_packages": withPackages == true ? 1 : 0,
        if (carType != null) "car_type": carType,
        if (district != null) "district": district,
      },
    );
    final response = await networkService.execute(
        request, (json) => TripAdvertisementsModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      badRequest: (data) {
        return data;
      },
      conflict: (data) {
        return data;
      },
      invalidParameters: (data) {
        return data;
      },
      noAccess: (data) {
        return data;
      },
      orElse: () {
        return;
      },
      noAuth: (data) {
        return data;
      },
      noData: (data) {
        return data;
      },
      notFound: (data) {
        return data;
      },
      unProcessable: (data) {
        return data;
      },
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
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: NetworkRequestBody.fromData(
        FormData.fromMap({
          if (servicesTypeid != null) "service_type_id": servicesTypeid,
          if (startingPlace != null) "starting_place": startingPlace,
          if (endingPlace != null) "ending_place": endingPlace,
          if (numberPassengers != null) "number_passengers": numberPassengers,
          if (nationality != null) "nationality": nationality,
          if (date != null) "date": date,
          if (time != null) "time": time,
          if (price != null) "price": price,
          if (withPackages != null)
            "with_packages": withPackages == true ? 1 : 0,
          if (carType != null) "car_type": carType,
          if (phone != null) "phone": phone,
          if (photos != null)
            "photos[]": photos
                .map(
                  (e) => MultipartFile.fromFileSync(
                    e.path,
                    filename: e.path.split('/').last,
                  ),
                )
                .toList(),
        }),
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
      badRequest: (data) {
        return data;
      },
      conflict: (data) {
        return data;
      },
      invalidParameters: (data) {
        return data;
      },
      noAccess: (data) {
        return data;
      },
      orElse: () {
        return;
      },
      noAuth: (data) {
        return data;
      },
      noData: (data) {
        return data;
      },
      notFound: (data) {
        return data;
      },
      unProcessable: (data) {
        return data;
      },
    );
    return data;
  }

  static Future<MainModel?> deleteTripAdsById(int id) async {
    final request = NetworkRequest(
      type: NetworkRequestType.DELETE,
      path: "${APIKeys.tripAds}/$id",
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: const NetworkRequestBody.empty(),
    );
    final response = await networkService.execute(
        request, (json) => MainModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      orElse: () {},
      badRequest: (data) {
        return data;
      },
      conflict: (data) {
        return data;
      },
      invalidParameters: (data) {
        return data;
      },
      noAccess: (data) {
        return data;
      },
      noData: (data) {
        return data;
      },
      notFound: (data) {
        return data;
      },
      unProcessable: (data) {
        return data;
      },
    );
    return data;
  }
}
