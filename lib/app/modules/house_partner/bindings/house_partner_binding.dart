import 'package:get/get.dart';

import '../controllers/house_partner_controller.dart';

class HousePartnerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HousePartnerController>(
      () => HousePartnerController(),
    );
  }
}
