import 'dart:developer';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/widgets/image_picker.dart';
import '../../../data/remote_data_source/favorites_and_report_apis.dart';
import '../../../data/remote_data_source/trip_ads.dart';
import '../../../routes/app_pages.dart';

class TravelPartnerController extends GetxController {
  int? travelPartner;
  clearData() {
    travelPartner = null;
    viewDate = null;
    update();
  }

  changeTravelPartnerState(int? val) {
    travelPartner = val;
    update();
  }

  DateTime? viewDate;
  onDateViewPickerChanged(val) {
    viewDate = val;
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
  DateTime? createAdsDate;
  String? createAdsDateError;
  DateTime? createAdsTime;
  String? createAdsTimeErorr;

//========================================================================
  changeWithPackstatus(String? val) {
    withPackval = val!;
    createTripAdsIsWithPack = val == "نعم" ? true : false;
    update();
  }

//========================================================================
  onDateCreatePickerChanged(val) {
    createAdsDate = val;
    update();
  }
  //========================================================================

  onTimeCreatePickerChanged(val) {
    createAdsTime = val;
    update();
  }

//========================================================================

  void pickCreateTripAdsImages() async {
    await ImagePickerDialog().pickGalleryImages(
      maxImage: 10,
      context: Get.context!,
      onGet: (value) {
        for (int i = 0; i < value.length; i++) {
          createTripAdsPhotos = [
            ...createTripAdsPhotos ?? [],
            File(value[i].path ?? "")
          ];
        }
      },
    );
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
    required String? date,
    required String? time,
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
        Get.offAllNamed(Routes.BOTTOM_NAV_BAR);
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
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      final res =
          await TripPartnerAPI.createTripComment(id: id, comment: comment);
      if (res?.status == true) {
        update();
        createCommentCtr.clear();
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

  //================================Filter==================================
  clearFilterData() {
    travelPartneFilter = 6;
    filterDate = null;
    filterTime = null;
    filterIsWithPack = true;
    filterPassengersCtr.clear();
    filterPriceCtr.clear();
    filterCarTypeCtr.clear();
    update();
  }

  int travelPartneFilter = 6;
  DateTime? filterDate;
  DateTime? filterTime;
  final filterwithPackstatus = ["نعم", "لا"];
  String filterwithPackval = "نعم";
  bool filterIsWithPack = true;
  TextEditingController filterPassengersCtr = TextEditingController();
  TextEditingController filterPriceCtr = TextEditingController();
  TextEditingController filterCarTypeCtr = TextEditingController();
//========================================================================
  changeWithPackFilterStatus(String? val) {
    filterwithPackval = val!;
    filterIsWithPack = val == "نعم" ? true : false;
    update();
  }

//========================================================================
  onDateFilterPickerChanged(val) {
    filterDate = val;
    update();
  }
  //========================================================================

  onTimeFilterPickerChanged(val) {
    filterTime = val;
    update();
  }

//========================================================================
  changeTravelPartnerFilterState(int val) {
    travelPartneFilter = val;
    update();
  }

  //========================================================================
  //========================================================================
  //===============================Trip Details=============================
  ScrollController scrollController = ScrollController();
  //========================================================================
  TextEditingController reportCtr = TextEditingController();
  Future createReport({
    required int id,
    required String report,
    required AnimationController animationController,
  }) async {
    try {
      animationController.forward();
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      final res = await FavoritesAndReportAPIS.createReport(
        type: Partners.tripAds,
        id: id,
        report: report,
      );
      if (res?.status == true) {
        animationController.forward();
        Future.delayed(1.milliseconds, () {
          animationController.reverse();
          Get.back();
        });
        reportCtr.clear();
        BotToast.showText(text: res?.message ?? "");
      } else {
        animationController.reset();
        BotToast.showText(text: res?.message ?? "");
      }
    } catch (e) {
      log(e.toString());
    }
  }

//========================================================================
  Future addToFavorites({
    required int id,
  }) async {
    try {
      BotToast.showLoading();
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      final res = await FavoritesAndReportAPIS.addToFavorites(
        type: Partners.tripAds,
        id: id,
      );
      if (res?.status == true) {
        BotToast.closeAllLoading();
        BotToast.showText(text: res?.message ?? "");
        Get.forceAppUpdate();
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
  void makePhoneCall(String phone) async {
    var url = 'tel:$phone';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  String? textSearch;
  TextEditingController searchController = TextEditingController();
  onChangedSearch(String value) {
    if (value.trim().isNotEmpty) {
      searchController.text = value;
      textSearch = value;
    } else {
      textSearch = value;
    }
    searchController.value = searchController.value.copyWith(
      text: value,
      selection: TextSelection.fromPosition(
        TextPosition(offset: value.length),
      ),
    );
    update();
  }

  Future deleteAds({
    required int id,
  }) async {
    try {
      BotToast.showLoading();
      var res = await TripPartnerAPI.deleteTripAdsById(id);
      if (res?.status == true) {
        BotToast.closeAllLoading();
        BotToast.showText(text: res?.message ?? "");
        Get.forceAppUpdate();
        Get.back();
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: res?.message ?? "");
      }
    } catch (e) {
      BotToast.closeAllLoading();
      log(e.toString());
    }
  }
}
