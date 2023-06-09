import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/global/const.dart';
import '../../../core/services/network_service.dart/dio_network_service.dart';
import '../../../core/services/shared_prefs.dart';
import '../models/main_model.dart';
import '../models/other_service_partner_item_model.dart';
import '../models/other_services_partener_model.dart';

class OtherServicesPartenerAPIS {
  static Future<OtherServicesPartenerModel?> getOtherAds(
    String? title,
  ) async {
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: APIKeys.otherAdsSearch,
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      queryParams: {
        if (title != null) "title": title,
      },
      data: const NetworkRequestBody.empty(),
    );
    final response = await networkService.execute(
        request, (json) => OtherServicesPartenerModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      orElse: () {},
    );
    return data;
  }

  static Future<OtherAdsItemModel?> getOtherAdsById(int id) async {
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: "${APIKeys.otherAds}/$id",
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: const NetworkRequestBody.empty(),
    );
    final response = await networkService.execute(
      request,
      (json) => OtherAdsItemModel.fromJson(json),
    );
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      orElse: () {},
    );
    return data;
  }

  static Future<MainModel?> createOtherComment({
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
      path: "${APIKeys.createOtherComment}/$id",
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

  static Future<MainModel?> createOtherAds({
    String? location,
    String? neighborhood,
    String? title,
    String? description,
    String? phone,
    List<File>? photos,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: APIKeys.otherAds,
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: NetworkRequestBody.fromData(
        FormData.fromMap({
          if (location != null) "location": location,
          if (neighborhood != null) "neighborhood": neighborhood,
          if (title != null) "title": title,
          if (description != null) "description": description,
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
