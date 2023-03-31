import 'package:get/get.dart';
import 'package:sharek/app/data/models/home_model.dart';
import 'package:sharek/app/data/remote_data_source/home_apis.dart';

class HomeController extends GetxController {
  late final Future<HomeModel?> getHomeData;
  @override
  void onInit() {
    getHomeData = HomeAPI.getHome();
    super.onInit();
  }
}
