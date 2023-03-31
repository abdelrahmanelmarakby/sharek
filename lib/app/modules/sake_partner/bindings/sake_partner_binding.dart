import 'package:get/get.dart';

import '../controllers/sake_partner_controller.dart';

class SakePartnerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SakePartnerController>(
      () => SakePartnerController(),
    );
  }
}
