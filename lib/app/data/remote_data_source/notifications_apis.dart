import 'package:sharek/core/global/const.dart';
import 'package:sharek/core/services/shared_prefs.dart';

import '../../../core/services/network_service.dart/dio_network_service.dart';
import '../models/notifications_model.dart';

class NotificationsAPI {
  static Future<NotificationsModel?> getAllNotifications() async {
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: APIKeys.notification,
      headers: {
        'Accept': 'application/json',
        'api_password': APIKeys.apiPassword,
        'Authorization':
            'Bearer ${SharedPrefService(prefs: globalPrefs).getToken()}',
      },
      data: const NetworkRequestBody.empty(),
    );
    final response = await networkService.execute(
        request, (json) => NotificationsModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      orElse: () {},
    );
    return data;
  }
}
