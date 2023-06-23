import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

import '../../../core/global/const.dart';
import '../../../core/services/network_service.dart/dio_network_service.dart';
import '../../../core/services/shared_prefs.dart';
import '../../routes/app_pages.dart';
import '../models/another_user_profile_view.dart';
import '../models/favorites_model.dart';
import '../models/main_model.dart';
import '../models/profile_model.dart';
import '../models/user_ads_model.dart';

class ProfileApis {
  static Future<MainModel?> updateAvatar({
    required File image,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: APIKeys.updateAvatar,
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: NetworkRequestBody.fromData(
        FormData.fromMap(
          {
            "avatar": MultipartFile.fromFileSync(
              image.path,
              filename: image.path.split('/').last,
            ),
          },
        ),
      ),
    );
    final response = await networkService.execute(
        request, (json) => MainModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      noAuth: (data) {
        SharedPrefService(prefs: globalPrefs).removeToken();
        Get.offAllNamed(Routes.AUTH);
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

  static Future<MainModel?> updateProfile({
    String? name,
    String? phone,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: APIKeys.updateProfile,
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: NetworkRequestBody.fromData(
        FormData.fromMap(
          {
            if (phone != null) "phone": phone,
            if (name != null) "name": name,
          },
        ),
      ),
    );
    final response = await networkService.execute(
        request, (json) => MainModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      noAuth: (data) {
        SharedPrefService(prefs: globalPrefs).removeToken();
        Get.offAllNamed(Routes.AUTH);
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

  static Future<MainModel?> logout() async {
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: APIKeys.logout,
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
        SharedPrefService(prefs: globalPrefs).removeToken();
        Get.offAllNamed(Routes.AUTH);
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

  static Future<UserInfoModel?> getUserProfile() async {
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: APIKeys.userInfo,
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
      (json) => UserInfoModel.fromJson(json),
    );
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      noAuth: (data) {
        SharedPrefService(prefs: globalPrefs).removeToken();
        Get.offAllNamed(Routes.AUTH);
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

  static Future<FavoritesModel?> getUserFavorites() async {
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: APIKeys.userFavorite,
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
      (json) => FavoritesModel.fromJson(json),
    );
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      noAuth: (data) {
        SharedPrefService(prefs: globalPrefs).removeToken();
        Get.offAllNamed(Routes.AUTH);
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

  static Future<UserAdsModel?> getUserAds() async {
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: APIKeys.userAds,
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
      (json) => UserAdsModel.fromJson(json),
    );
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      noAuth: (data) {
        SharedPrefService(prefs: globalPrefs).removeToken();
        Get.offAllNamed(Routes.AUTH);
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

  static Future<AnotherUserProfile?> getAnotherUserProfile(int id) async {
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: APIKeys.anotherUserInfo + id.toString(),
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
      (json) => AnotherUserProfile.fromJson(json),
    );
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      noAuth: (data) {
        SharedPrefService(prefs: globalPrefs).removeToken();
        Get.offAllNamed(Routes.AUTH);
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

  static Future<MainModel?> updateNotificationStatus({
    required bool status,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: "notification/status",
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: NetworkRequestBody.fromData(
        FormData.fromMap(
          {
            "status": status ? 1 : 0,
          },
        ),
      ),
    );
    final response = await networkService.execute(
        request, (json) => MainModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      noAuth: (data) {
        SharedPrefService(prefs: globalPrefs).removeToken();
        Get.offAllNamed(Routes.AUTH);
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

  static Future<MainModel?> updatePhoneStatus({
    required bool status,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: "phone/status",
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: NetworkRequestBody.fromData(
        FormData.fromMap(
          {
            "status": status ? 1 : 0,
          },
        ),
      ),
    );
    final response = await networkService.execute(
        request, (json) => MainModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      noAuth: (data) {
        SharedPrefService(prefs: globalPrefs).removeToken();
        Get.offAllNamed(Routes.AUTH);
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

  static Future<MainModel?> deleteAccount({
    required String phone,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: "delete-account",
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: NetworkRequestBody.fromData(
        FormData.fromMap(
          {
            "phone": phone,
          },
        ),
      ),
    );
    final response = await networkService.execute(
        request, (json) => MainModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      noAuth: (data) {
        SharedPrefService(prefs: globalPrefs).removeToken();
        Get.offAllNamed(Routes.AUTH);
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
