import 'package:get/get.dart';

import '../../../data/models/notifications_model.dart';
import '../../../data/remote_data_source/notifications_apis.dart';

class NotificationsController extends GetxController {
  late final Future<NotificationsModel?> notifications;
  @override
  void onInit() {
    notifications = NotificationsAPI.getAllNotifications();
    super.onInit();
  }
}
