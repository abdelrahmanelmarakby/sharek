import 'package:get/get.dart';

import '../controllers/travel_partner_controller.dart';

class TravelPartnerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TravelPartnerController>(
      () => TravelPartnerController(),
      fenix: true
    );
  }
}
