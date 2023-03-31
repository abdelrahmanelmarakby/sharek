import 'package:get/get.dart';

import '../controllers/business_partner_controller.dart';

class BusinessPartnerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusinessPartnerController>(
      () => BusinessPartnerController(),
      fenix: true,
    );
  }
}
