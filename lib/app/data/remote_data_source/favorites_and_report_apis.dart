import 'package:dio/dio.dart';

import '../../../core/global/const.dart';
import '../../../core/services/network_service.dart/dio_network_service.dart';
import '../../../core/services/shared_prefs.dart';
import '../models/main_model.dart';

enum Partners {
  businessAds,
  tripAds,
  housingAds,
  otherAds,
  sacrificeAds,
}

class FavoritesAndReportAPIS {
  static Future<MainModel?> createReport({
    required Partners type,
    required int id,
    required String report,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      path: type == Partners.businessAds
          ? "${APIKeys.reportBusinessAds}/$id"
          : type == Partners.housingAds
              ? "${APIKeys.reportHousingAds}/$id"
              : type == Partners.tripAds
                  ? "${APIKeys.reportTripAds}/$id"
                  : type == Partners.sacrificeAds
                      ? "${APIKeys.reportSacrificeAds}/$id"
                      : "${APIKeys.reportOtherAds}/$id",
      data: NetworkRequestBody.fromData(
        FormData.fromMap(
          {
            "report": report,
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

  static Future<MainModel?> addToFavorites({
    required Partners type,
    required int id,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      path: type == Partners.businessAds
          ? "${APIKeys.favoriteBusinessAds}/$id"
          : type == Partners.housingAds
              ? "${APIKeys.favoriteHousingAds}/$id"
              : type == Partners.tripAds
                  ? "${APIKeys.favoriteTripAds}/$id"
                  : type == Partners.sacrificeAds
                      ? "${APIKeys.favoriteSacrificeAds}/$id"
                      : "${APIKeys.favoriteOtherAds}/$id",
      data: const NetworkRequestBody.empty(),
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
}
