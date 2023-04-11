import 'package:sharek/core/global/const.dart';
import 'package:sharek/core/services/network_service.dart/dio_network_service.dart';

import '../../../core/services/shared_prefs.dart';
import '../models/home_model.dart';

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
    );
    return data;
  }
}
