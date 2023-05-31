import 'package:get/get.dart';

import '../../../data/models/notifications_model.dart';
import '../../../data/remote_data_source/notifications_apis.dart';

class NotificationsController extends GetxController {
<<<<<<< HEAD
  final count = 0.obs;

  void increment() => count.value++;
=======
  late final Future<NotificationsModel?> notifications;
  @override
  void onInit() {
    notifications = NotificationsAPI.getAllNotifications();
    super.onInit();
  }
>>>>>>> ffe62141da1f51e1c81c8e8387c9fac7d788e899
}
