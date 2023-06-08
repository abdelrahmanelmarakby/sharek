import 'package:get/get.dart';

import '../controllers/another_user_profile_controller.dart';

class AnotherUserProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnotherUserProfileController>(
      () => AnotherUserProfileController(),
    );
  }
}
