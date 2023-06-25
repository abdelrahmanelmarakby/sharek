import 'package:get/get.dart';
import 'package:sharek/core/global/const.dart';
import 'package:sharek/core/services/network_service.dart/dio_network_service.dart';

import '../../../core/services/shared_prefs.dart';
import '../../routes/app_pages.dart';
import '../models/home_model.dart';
import '../models/home_search_model.dart';

class HomeAPI {
  static Future<HomeModel?> getHome() async {
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: APIKeys.home,
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: const NetworkRequestBody.empty(),
    );
    final response = await networkService.execute(
        request, (json) => HomeModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      orElse: () {},
      badRequest: (data) {
        return data;
      },
      noAuth: (data) {
        SharedPrefService(prefs: globalPrefs).removeToken();
        Get.offAllNamed(Routes.AUTH);
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

  static Future<HomeSearchModel?> searchHomeAds({String? search}) async {
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: APIKeys.homeSearch,
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      queryParams: {
        if (search != null) "search": search,
        "location": "الرياض",
      },
      data: const NetworkRequestBody.empty(),
    );

    final response = await networkService.execute(
      request,
      (json) => HomeSearchModel.fromJson(json),
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
      noAuth: (data) {
        SharedPrefService(prefs: globalPrefs).removeToken();
        Get.offAllNamed(Routes.AUTH);
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
