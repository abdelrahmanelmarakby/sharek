import 'package:dio/dio.dart';
import 'package:sharek/app/data/models/user_model.dart';

import '../../../core/global/const.dart';
import '../../../core/services/firebase_messaging_helper.dart';
import '../../../core/services/network_service.dart/dio_network_service.dart';
import '../models/main_model.dart';

class AuthApis {
  static Future<MainModel?> register({
    required String name,
    required String phone,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: APIKeys.register,
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

  static Future<MainModel?> login({
    required String phone,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: APIKeys.login,
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
      orElse: () {},
    );
    return data;
  }

  static Future<UserModel?> loginOtp({
    required String phone,
    required String code,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: APIKeys.otpLogin,
      data: NetworkRequestBody.fromData(
        FormData.fromMap(
          {
            "phone": phone,
            "code": code,
            "device_token": await FirebaseMessagingHelper.getToken(),
          },
        ),
      ),
    );
    final response = await networkService.execute(
        request, (json) => UserModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      orElse: () {},
    );
    return data;
  }

  static Future<UserModel?> registerOtp({
    required String phone,
    required String code,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: APIKeys.otpRegister,
      data: NetworkRequestBody.fromData(
        FormData.fromMap(
          {
            "phone": phone,
            "code": code,
            "device_token": await FirebaseMessagingHelper.getToken(),
          },
        ),
      ),
    );
    final response = await networkService.execute(
        request, (json) => UserModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      orElse: () {},
    );
    return data;
  }
}
