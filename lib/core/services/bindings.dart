import 'package:get/get.dart';
import 'package:sharek/app/modules/bottom_nav_bar/controllers/bottom_nav_bar_controller.dart';
import 'package:sharek/app/modules/home/controllers/home_controller.dart';

import '../../app/modules/location_getter_widgets/controllers/location_getter_widgets_controller.dart';
import '../../app/modules/notifications/controllers/notifications_controller.dart';
import '../../app/modules/profile/controllers/profile_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
      fenix: true,
    );
    Get.lazyPut<BottomNavBarController>(
      () => BottomNavBarController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
      fenix: true,
    );
    Get.lazyPut<LocationGetterWidgetsController>(
      () => LocationGetterWidgetsController(),
      fenix: true,
    );

    Get.lazyPut<NotificationsController>(
      () => NotificationsController(),
    );
  }
}
