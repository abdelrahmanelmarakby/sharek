import 'package:get/get.dart';

import '../../../data/models/trip_ads_model.dart';
import '../../../data/remote_data_source/trip_ads.dart';

class TravelPartnerController extends GetxController {
  

  int? travelPartner ;
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
