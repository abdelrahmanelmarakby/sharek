import 'package:get/get.dart';

import '../controllers/other_service_partner_controller.dart';

class OtherServicePartnerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtherServicePartnerController>(
      () => OtherServicePartnerController(),
    );
  }
}
