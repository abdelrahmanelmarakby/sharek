import 'dart:developer';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sharek/app/data/remote_data_source/business_ads.dart';
import 'package:sharek/app/routes/app_pages.dart';

import '../../../data/remote_data_source/favorites_and_report_apis.dart';

class BusinessPartnerController extends GetxController {
  int? businessPartner;
  clearData() {
    businessPartner = null;
    update();
  }

  changeBusinessPartnerState(int val) {
    businessPartner = val;
    update();
  }

//==============================createBusnissAds=============================

  List<File>? createTripAdsPhotos;
  GlobalKey<FormState> createAdsFormKey = GlobalKey<FormState>();
  TextEditingController createTitlePartnersCtr = TextEditingController();
  TextEditingController createDescriptionPartnersCtr = TextEditingController();
  TextEditingController createAdPhoneCtr = TextEditingController();

  List<File>? createPhotos;
//========================================================================

  void pickCreateTripAdsImages() async {
    List<XFile> pickedImages = await ImagePicker().pickMultiImage();
    if (pickedImages.isEmpty) return;
    createTripAdsPhotos = pickedImages.map((e) => File(e.path)).toList();
    update();
  }

//========================================================================
  void pickCreateAdsImages() async {
    List<XFile> pickedImages = await ImagePicker().pickMultiImage();
    if (pickedImages.isEmpty) return;
    createPhotos = pickedImages.map((e) => File(e.path)).toList();
    update();
  }

//========================================================================
  Future createTripAds({
    required AnimationController animationController,
    int? servicesTypeid,
    String? title,
    String? location,
    String? neighborhood,
    String? phone,
    String? description,
    List<File>? photos,
  }) async {
    animationController.forward();
    try {
      final res = await BusinessPartnerAPI.createBusinessAds(
        description: description,
        neighborhood: neighborhood,
        phone: phone,
        photos: photos,
        servicesTypeid: servicesTypeid,
        location: location,
        title: title,
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
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      final res = await BusinessPartnerAPI.createBusinessComment(
          id: id, comment: comment);
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
    location.clear();
    city.clear();
    update();
  }

  TextEditingController city = TextEditingController();
  TextEditingController location = TextEditingController();

  //========================================================================
  //========================================================================
  //===============================Trip Details=============================
  ScrollController scrollController = ScrollController();
  double scrollPosition = 0;
  bool isCenter = false;
  scrollListener() {
    scrollPosition = scrollController.position.pixels;
    if (scrollPosition >= scrollController.position.minScrollExtent) {
      isCenter = true;
      // update();
    } else {
      isCenter = false;
    }
    log(scrollPosition.toString());
  }

  @override
  void onInit() {
    scrollController.addListener(() {
      scrollListener();
    });
    super.onInit();
  }

  //========================================================================
  //===============================report==================================
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
        type: Partners.businessAds,
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
        type: Partners.businessAds,
        id: id,
      );
      if (res?.status == true) {
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
}
