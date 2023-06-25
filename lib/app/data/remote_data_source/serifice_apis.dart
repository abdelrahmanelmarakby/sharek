import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:sharek/app/routes/app_pages.dart';
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
    String? quantity,
    String? title,
        String? district,

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
        if (servicesTypeid != null) "service_type_id": servicesTypeid,
        if (location != null) "location": location,
        if (title != null) "title": title,
        if (neighborhood != null) "neighborhood": neighborhood,
        if (sacrificeType != null) "sacrifice_type": sacrificeType,
        if (quantity != null) "quantity": quantity,
                if (district != null) "district": district,

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
    String? district,
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
        FormData.fromMap({
          if (servicesTypeid != null) "service_type_id": servicesTypeid,
          if (location != null) "location": location,
          if (neighborhood != null) "neighborhood": neighborhood,
          if (title != null) "title": title,
          if (description != null) "description": description,
          if (phone != null) "phone": phone,
          if (sacrificeType != null) "sacrifice_type": sacrificeType,
          if (eighthPrice != null) "eighth_price": eighthPrice,
          if (eighthQuantity != null) "eighth_quantity": eighthQuantity,
          if (quarterPrice != null) "quarter_price": quarterPrice,
          if (quarterQuantity != null) "quarter_quantity": quarterQuantity,
          if (thirdPrice != null) "third_price": thirdPrice,
          if (thirdQuantity != null) "third_quantity": thirdQuantity,
          if (halfPrice != null) "half_price": halfPrice,
          if (halfQuantity != null) "half_quantity": halfQuantity,
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
      noAuth: (data) => Get.toNamed(Routes.AUTH),
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

  static Future<MainModel?> deleteSarificeAdsById(int id) async {
    final request = NetworkRequest(
      type: NetworkRequestType.DELETE,
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
