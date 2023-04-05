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

  onTimerDurationChanged(Duration changeTimer) {
    initialTimer = changeTimer;
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

  //===============================Comment==================================
  TextEditingController createCommentCtr = TextEditingController();
  bool isText = false;
  onChangedComment(String value) {
    if (value.trim().isNotEmpty) {
      createCommentCtr.text = value;
      isText = true;
    } else {
      isText = false;
    }
    createCommentCtr.value = createCommentCtr.value.copyWith(
      text: value,
      selection: TextSelection.fromPosition(
        TextPosition(offset: value.length),
      ),
    );
    update();
  }

  //========================================================================
  Future createComment({
    required int id,
    required String comment,
  }) async {
    try {
      BotToast.showLoading();
      final res =
          await TripPartnerAPI.createTripComment(id: id, comment: comment);
      if (res?.status == true) {
        createCommentCtr.clear();
        update();
        BotToast.closeAllLoading();
        BotToast.showText(text: res?.message ?? "");
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: res?.message ?? "");
      }
    } catch (e) {
      BotToast.closeAllLoading();
      log(e.toString());
    }
  }
  //========================================================================
  //========================================================================
}
