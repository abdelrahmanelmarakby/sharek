import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:sharek/app/data/models/business_ad_model.dart';
import 'package:sharek/app/data/models/business_ads_model.dart';
import 'package:sharek/app/data/models/main_model.dart';
import 'package:sharek/app/routes/app_pages.dart';
import 'package:sharek/core/global/const.dart';
import 'package:sharek/core/services/network_service.dart/dio_network_service.dart';

import '../../../core/services/shared_prefs.dart';

class BusinessPartnerAPI {
  static Future<BusinessPartnerModel?> getBusinessAds() async {
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: APIKeys.businessAdsSearch,
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: const NetworkRequestBody.empty(),
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
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: const NetworkRequestBody.empty(),
    );
    final response = await networkService.execute(
        request, (json) => BusinessPartnerAdModel.fromJson(json));
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

  static Future<MainModel?> createBusinessComment({
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
      noAuth: (data) => Get.toNamed(Routes.AUTH),
      orElse: () {
        return;
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

  static Future<BusinessPartnerModel?> filterBusinessAds({
    int? servicesTypeid,
    String? location,
    String? city,
    String? title,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: APIKeys.businessAdsSearch,
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      queryParams: {
        "service_type_id": servicesTypeid,
        if (location != null) "location": location,
        if (city != null) "neighborhood": city,
        if (title != null) "title": title,
      },
      data: const NetworkRequestBody.empty(),
    );

    final response = await networkService.execute(
        request, (json) => BusinessPartnerModel.fromJson(json));
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
      noAuth: (data) {
        Get.toNamed(Routes.AUTH);
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

  static Future<MainModel?> createBusinessAds({
    bool update = false,
    int? id,
    int? servicesTypeid,
    int? type,
    String? title,
    String? location,
    String? neighborhood,
    String? phone,
    String? description,
    List<File>? photos,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: update
          ? "${APIKeys.update}${APIKeys.businessAds}/$id"
          : APIKeys.businessAds,
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: NetworkRequestBody.fromData(
        FormData.fromMap(
          {
            if (type != null) "type": type,
            "service_type_id": servicesTypeid,
            if (location != null) "location": location,
            if (neighborhood != null) "neighborhood": neighborhood,
            if (title != null) "title": title,
            if (description != null) "description": description,
            if (phone != null) "phone": phone,
            if (photos != null)
              "photos[]": photos
                  .map((e) => MultipartFile.fromFileSync(e.path,
                      filename: e.path.split('/').last))
                  .toList(),
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
      noAuth: (data) => Get.toNamed(Routes.AUTH),
      orElse: () {
        return;
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

  static Future<MainModel?> deleteBusinessAdById(int id) async {
    final request = NetworkRequest(
      type: NetworkRequestType.DELETE,
      path: "${APIKeys.businessAds}/$id",
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
      noAuth: (data) {
        return data;
      },
      orElse: () {
        return;
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
