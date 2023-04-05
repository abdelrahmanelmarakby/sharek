import 'dart:developer';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/remote_data_source/trip_ads.dart';
import '../../../routes/app_pages.dart';

class TravelPartnerController extends GetxController {
  int? travelPartner;
  clearData() {
    travelPartner = null;
    update();
  }

  changeTravelPartnerState(int val) {
    travelPartner = val;
    update();
  }

  int travelPartneFilter = 6;
  changeTravelPartnerFilterState(int val) {
    travelPartneFilter = val;
    update();
  }

  double currentImageStepper = 0;
  changeImageStepper(double val) {
    currentImageStepper = val;
    update();
  }

  Duration initialTimer = const Duration();
  String? time;
  onTimerDurationChanged(Duration changeTimer) {
    initialTimer = changeTimer;
    time =
        '${changeTimer.inHours} hrs ${changeTimer.inMinutes % 60} mins ${changeTimer.inSeconds % 60} secs';
    update();
  }

//==============================createTripAds=============================
  final withPackstatus = ["نعم", "لا"];
  String withPackval = "نعم";
  bool createTripAdsIsWithPack = true;
  List<File>? createTripAdsPhotos;
  GlobalKey<FormState> createTripAdsFormKey = GlobalKey<FormState>();
  TextEditingController createTripAdsNumberPassengersCtr =
      TextEditingController();
  TextEditingController createTripAdsDateCtr = TextEditingController();
  TextEditingController createTripAdsTimeCtr = TextEditingController();
  TextEditingController createTripAdPhoneCtr = TextEditingController();
  TextEditingController createTripAdsPriceCtr = TextEditingController();
  TextEditingController createTripAdsCarTypeCtr = TextEditingController();
//========================================================================
  changeWithPackstatus(String? val) {
    withPackval = val!;
    createTripAdsIsWithPack = val == "نعم" ? true : false;
    update();
  }

//========================================================================
  void pickCreateTripAdsImages() async {
    List<XFile> pickedImages = await ImagePicker().pickMultiImage();
    if (pickedImages.isEmpty) return;
    createTripAdsPhotos = pickedImages.map((e) => File(e.path)).toList();
    update();
  }

//========================================================================
  int addTravelPartner = 6;
  changeAddTravelPartnerState(int val) {
    addTravelPartner = val;
    update();
  }

//========================================================================
  Future createTripAds({
    required AnimationController animationController,
    required int servicesTypeid,
    required String startingPlace,
    required int numberPassengers,
    required String endingPlace,
    required String nationality,
    required String date,
    required String time,
    String? phone,
    List<File>? photos,
    required double price,
    required bool withPackages,
    String? carType,
  }) async {
    animationController.forward();
    try {
      final res = await TripPartnerAPI.createTripAds(
        carType: carType,
        date: date,
        endingPlace: endingPlace,
        nationality: nationality,
        numberPassengers: numberPassengers,
        phone: phone,
        photos: photos,
        price: price,
        servicesTypeid: servicesTypeid,
        startingPlace: startingPlace,
        time: time,
        withPackages: withPackages,
      );
      if (res?.status == true) {
        animationController.reset();

        BotToast.showText(text: res?.message ?? "");
        Get.toNamed(Routes.BOTTOM_NAV_BAR);
      } else {
        animationController.reset();
        BotToast.showText(text: res?.message ?? "");
      }
    } catch (e) {
      log(e.toString());
    }
  }
  //========================================================================
}
