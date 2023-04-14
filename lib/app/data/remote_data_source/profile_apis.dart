import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

import '../../../core/global/const.dart';
import '../../../core/services/network_service.dart/dio_network_service.dart';
import '../../../core/services/shared_prefs.dart';
import '../../routes/app_pages.dart';
import '../models/main_model.dart';

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
      orElse: () {},
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
            "phone": phone,
            "name": name,
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
      orElse: () {},
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
    );
    return data;
  }
}
