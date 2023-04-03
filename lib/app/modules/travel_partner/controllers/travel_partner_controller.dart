import 'package:get/get.dart';

import '../../../data/models/trip_ads_model.dart';
import '../../../data/models/trip_services_type_model.dart';
import '../../../data/remote_data_source/trip_ads.dart';

class TravelPartnerController extends GetxController {
  late final Future<TripAdvertisementsModel?> getTripAds;
  late final Future<TripServiceTypeModel?> getTripServicesTypes;
  @override
  void onInit() {
    getTripServicesTypes = TripPartnerAPI.getTripServicesTypes();
    getTripAds = TripPartnerAPI.getTripAds();
    super.onInit();
  }
  int travelPartner = 0;
  changeTravelPartnerState(int val) {
    travelPartner = val;
    update();
  }
}
