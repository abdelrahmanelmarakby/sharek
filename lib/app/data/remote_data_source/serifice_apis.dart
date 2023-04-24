import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sharek/core/services/network_service.dart/dio_network_service.dart';

import '../../../core/global/const.dart';
import '../../../core/services/shared_prefs.dart';
import '../models/main_model.dart';
import '../models/sarifice_ad_item_model.dart';
import '../models/sarifice_ads_model.dart';

class SarificeAPIS {
  static Future<SarificeAdsModel?> getSarificeAds() async {
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: APIKeys.sacrificeAds,
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: const NetworkRequestBody.empty(),
    );
    final response = await networkService.execute(
        request, (json) => SarificeAdsModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      orElse: () {},
    );
    return data;
  }

  static Future<SarificeAdItemModel?> getSarificeAdsById(int id) async {
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: "${APIKeys.sacrificeAds}/$id",
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: const NetworkRequestBody.empty(),
    );
    final response = await networkService.execute(
        request, (json) => SarificeAdItemModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      orElse: () {},
    );
    return data;
  }

  static Future<MainModel?> createSerificeComment({
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
      path: "${APIKeys.createSacrificeComment}/$id",
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
      badRequest: (data) {
        return data;
      },
      invalidParameters: (data) {
        return data;
      },
      notFound: (data) {
        return data;
      },
      conflict: (data) {
        return data;
      },
      unProcessable: (data) {
        return data;
      },
      noAuth: (data) {
        return data;
      },
      noAccess: (data) {
        return data;
      },
      orElse: () {
        return;
      },
    );
    return data;
  }

  static Future<SarificeAdsModel?> filterSerificeAds({
    int? servicesTypeid,
    String? location,
    String? neighborhood,
    String? sacrificeType,
    int? eighth,
    int? third,
    int? quarter,
    int? half,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: APIKeys.sacrificeAdsSearch,
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: const NetworkRequestBody.empty(),
      queryParams: {
        "service_type_id": servicesTypeid,
        "location": location,
        "neighborhood": neighborhood,
        "sacrifice_type": sacrificeType,
        "eighth": eighth,
        "third": third,
        "quarter": quarter,
        "half": half,
      },
    );
    final response = await networkService.execute(
      request,
      (json) => SarificeAdsModel.fromJson(json),
    );
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      badRequest: (data) {
        return data;
      },
      invalidParameters: (data) {
        return data;
      },
      notFound: (data) {
        return data;
      },
      conflict: (data) {
        return data;
      },
      unProcessable: (data) {
        return data;
      },
      noAuth: (data) {
        return data;
      },
      noAccess: (data) {
        return data;
      },
      orElse: () {
        return;
      },
    );
    return data;
  }

  static Future<MainModel?> createSerificeAds({
    int? servicesTypeid,
    String? location,
    String? neighborhood,
    String? title,
    String? description,
    String? phone,
    List<File>? photos,
    String? sacrificeType,
    int? eighthPrice,
    int? eighthQuantity,
    int? thirdPrice,
    int? thirdQuantity,
    int? quarterPrice,
    int? quarterQuantity,
    int? halfPrice,
    int? halfQuantity,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: APIKeys.sacrificeAds,
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: NetworkRequestBody.fromData(
        FormData.fromMap(
          photos != null
              ? {
                  "service_type_id": servicesTypeid,
                  "location": location,
                  "neighborhood": neighborhood,
                  "title": title,
                  "description": description,
                  "phone": phone,
                  "sacrifice_type": sacrificeType,
                  "eighth_price": eighthPrice,
                  "eighth_quantity": eighthQuantity,
                  "quarter_price": quarterPrice,
                  "quarter_quantity": quarterQuantity,
                  "third_price": thirdPrice,
                  "third_quantity": thirdQuantity,
                  "half_price": halfPrice,
                  "half_quantity": halfQuantity,
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
                  "location": location,
                  "neighborhood": neighborhood,
                  "title": title,
                  "description": description,
                  "phone": phone,
                  "sacrifice_type": sacrificeType,
                  "eighth_price": eighthPrice,
                  "eighth_quantity": eighthQuantity,
                  "quarter_price": quarterPrice,
                  "quarter_quantity": quarterQuantity,
                  "third_price": thirdPrice,
                  "third_quantity": thirdQuantity,
                  "half_price": halfPrice,
                  "half_quantity": halfQuantity,
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
      badRequest: (data) {
        return data;
      },
      invalidParameters: (data) {
        return data;
      },
      notFound: (data) {
        return data;
      },
      conflict: (data) {
        return data;
      },
      unProcessable: (data) {
        return data;
      },
      noAuth: (data) {
        return data;
      },
      noAccess: (data) {
        return data;
      },
      orElse: () {
        return;
      },
    );
    return data;
  }

  static Future<SarificeAdItemModel?> sacrificeReservation({
    required int id,
    required String quantity,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: "${APIKeys.sacrificeReservation}/$id",
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: NetworkRequestBody.fromData(
        FormData.fromMap(
          {
            "quantity": quantity,
          },
        ),
      ),
    );
    final response = await networkService.execute(
        request, (json) => SarificeAdItemModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      badRequest: (data) {
        return data;
      },
      invalidParameters: (data) {
        return data;
      },
      notFound: (data) {
        return data;
      },
      conflict: (data) {
        return data;
      },
      unProcessable: (data) {
        return data;
      },
      noAuth: (data) {
        return data;
      },
      noAccess: (data) {
        return data;
      },
      orElse: () {
        return;
      },
    );
    return data;
  }
}
