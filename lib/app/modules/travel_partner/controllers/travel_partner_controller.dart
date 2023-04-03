import 'package:get/get.dart';

import '../../../data/models/trip_ads_model.dart';
import '../../../data/remote_data_source/trip_ads.dart';

class TravelPartnerController extends GetxController {
  late final Future<TripAdvertisementsModel?> getTripAds;
  @override
  void onInit() {
    getTripAds = TripPartnerAPI.getTripAds();
    super.onInit();
  }

  int travelPartner = 6;
  changeTravelPartnerState(int val) {
    travelPartner = val;
    update();
  }

  int addTravelPartner = 6;
  changeAddTravelPartnerState(int val) {
    addTravelPartner = val;
    update();
  }

  double currentImageStepper = 0;
  changeImageStepper(double val) {
    currentImageStepper = val;
    update();
  }

  final status = ["نعم", "لا"];
    int stackIndex = 0;

}
