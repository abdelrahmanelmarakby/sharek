import 'dart:developer';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sharek/app/data/remote_data_source/house_ads_apis.dart';

import '../../../routes/app_pages.dart';

class HousePartnerController extends GetxController {
  ScrollController scrollController = ScrollController();

  int? housePartner;
  changeHousePartnerState(int val) {
    housePartner = val;
    update();
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
          await HousePartnerAPI.createHouseComment(id: id, comment: comment);
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

//==============================createTripAds=============================
  List<File>? createHouseAdsPhotos;
  GlobalKey<FormState> createHouseAdsFormKey = GlobalKey<FormState>();

  TextEditingController createHouseAdPhoneCtr = TextEditingController();
  TextEditingController createHouseAdnumberPartnersCtr =
      TextEditingController();

//========================================================================

//========================================================================
  void pickCreateTripAdsImages() async {
    List<XFile> pickedImages = await ImagePicker().pickMultiImage();
    if (pickedImages.isEmpty) return;
    createHouseAdsPhotos = pickedImages.map((e) => File(e.path)).toList();
    update();
  }

//========================================================================
  int addHousePartner = 10;
  changeAddHousePartnerState(int val) {
    addHousePartner = val;
    update();
  }

//========================================================================
  Future createTripAds({
    required AnimationController animationController,
    required int servicesTypeid,
    required String location,
    required int numberPartners,
    required String neighborhood,
    required String nationality,
    required String? description,
    required String? title,
    String? phone,
    List<File>? photos,
  }) async {
    animationController.forward();
    try {
      final res = await HousePartnerAPI.createHouseAds(
        servicesTypeid: servicesTypeid,
        nationality: nationality,
        phone: phone,
        photos: photos,
        description: description,
        location: location,
        neighborhood: neighborhood,
        numberPartners: numberPartners,
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
}
