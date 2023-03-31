import 'package:get/get.dart';
import 'package:sharek/app/data/models/ads_model.dart';
import 'package:sharek/app/data/remote_data_source/business_ads.dart';

class BusinessPartnerController extends GetxController {
  late final Future<AdsModel?> getBusinessAds;
  @override
  void onInit() {
    getBusinessAds = BusinessPartnerAPI.getBusinessAds();
    super.onInit();
  }
}
