import 'package:get/get.dart';

import '../controllers/location_getter_widgets_controller.dart';

class LocationGetterWidgetsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationGetterWidgetsController>(
      () => LocationGetterWidgetsController(),
    );
  }
}
