import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sharek/core/global/const.dart';
import 'package:sharek/core/services/network_service.dart/dio_network_service.dart';
import '../../../core/services/shared_prefs.dart';
import '../models/house_partner_item_model.dart';
import '../models/house_partners_model.dart';
import '../models/main_model.dart';

class HousePartnerAPI {
  static Future<HousePartnersModel?> getHouseAds() async {
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: APIKeys.housingAds,
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: const NetworkRequestBody.empty(),
    );
    final response = await networkService.execute(
        request, (json) => HousePartnersModel.fromJson(json));
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

  static Future<HousePartnerItemModel?> getHouseAdsById(int id) async {
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: "${APIKeys.housingAds}/$id",
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: const NetworkRequestBody.empty(),
    );
    final response = await networkService.execute(
        request, (json) => HousePartnerItemModel.fromJson(json));
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

  static Future<MainModel?> createHouseComment({
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
      path: "${APIKeys.createhousingComment}/$id",
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

  static Future<HousePartnersModel?> filterHouseAds({
    int? servicesTypeid,
    String? location,
    int? numberPartners,
    String? neighborhood,
    String? nationality,
    String? title,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: APIKeys.housingAdsSearch,
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: const NetworkRequestBody.empty(),
      queryParams: {
        if (servicesTypeid != null) "service_type_id": servicesTypeid,
        if (location != null) "location": location,
        if (neighborhood != null) "neighborhood": neighborhood,
        if (numberPartners != null) "number_partners": numberPartners,
        if (nationality != null) "nationality": nationality,
        if (title != null) "title": title,
      },
    );
    final response = await networkService.execute(
        request, (json) => HousePartnersModel.fromJson(json));
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

  static Future<MainModel?> createHouseAds({
    int? servicesTypeid,
    String? location,
    int? numberPartners,
    String? neighborhood,
    String? nationality,
    String? title,
    String? description,
    String? phone,
    String? district,
    List<File>? photos,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: APIKeys.housingAds,
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: NetworkRequestBody.fromData(
        FormData.fromMap({
          if (servicesTypeid != null) "service_type_id": servicesTypeid,
          if (location != null) "location": location,
          if (neighborhood != null) "neighborhood": neighborhood,
          if (numberPartners != null) "number_partners": numberPartners,
          if (nationality != null) "nationality": nationality,
          if (title != null) "title": title,
          if (description != null) "description": description,
          if (phone != null) "phone": phone,
          if (district != null) "district": district,
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

  static Future<MainModel?> deleteHouseAdsById(int id) async {
    final request = NetworkRequest(
      type: NetworkRequestType.DELETE,
      path: "${APIKeys.housingAds}/$id",
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
