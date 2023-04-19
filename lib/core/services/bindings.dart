import 'package:get/get.dart';
import 'package:sharek/app/modules/home/controllers/home_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
      fenix: true,
    );
  }
}
