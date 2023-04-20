import 'dart:developer';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/service_type.dart';
import '../../../data/remote_data_source/serifice_apis.dart';

class SakePartnerController extends GetxController {
  ScrollController scrollController = ScrollController();

  //====================================================================
  int? sacrificePartner;
  changeSacrificePartnerState(int val) {
    sacrificePartner = val;
    update();
  }

//======================================================================
  List<ServiceTypeModel> sacrificeType = [
    ServiceTypeModel(name: "حاشي", serviceTypeId: 1),
    ServiceTypeModel(name: "خروف", serviceTypeId: 2),
    ServiceTypeModel(name: "عجل", serviceTypeId: 3),
    ServiceTypeModel(name: "تيس", serviceTypeId: 4),
  ];
  ServiceTypeModel? sacrificeTypeItem;

  changeSacrificeTypeState(ServiceTypeModel val) {
    sacrificeTypeItem = val;
    update();
  }

  //====================================================================
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
          await SarificeAPIS.createSerificeComment(id: id, comment: comment);
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

  //========================================================================
  clearSakeQuantityData() {
    sacrificeReservation = null;
    sacrificeReservationId = null;
  }

  String? sacrificeReservation;
  int? sacrificeReservationId;
  changesacrificeReservationState(String val, int id) {
    sacrificeReservation = val;
    sacrificeReservationId = id;
    update();
  }

  Future createSacrificeReservation({
    required AnimationController animationController,
    required int id,
    required String quantity,
  }) async {
    animationController.forward();
    try {
      final res =
          await SarificeAPIS.sacrificeReservation(id: id, quantity: quantity);
      if (res?.status == true) {
        animationController.reset();
        BotToast.showText(text: res?.message ?? "");
      } else {
        animationController.reset();
        BotToast.showText(text: res?.message ?? "");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //===============================================================
  List<File>? createPhotos;
  GlobalKey<FormState> createFormKey = GlobalKey<FormState>();
  TextEditingController createPhoneCtr = TextEditingController();
  TextEditingController createTitlePartnersCtr = TextEditingController();
  TextEditingController createDescriptionPartnersCtr = TextEditingController();

//========================================================================

//========================================================================
  void pickCreateAdsImages() async {
    List<XFile> pickedImages = await ImagePicker().pickMultiImage();
    if (pickedImages.isEmpty) return;
    createPhotos = pickedImages.map((e) => File(e.path)).toList();
    update();
  }

//========================================================================

  clearCreateData() {
    createPhotos = null;
    createPhoneCtr.clear();
    createTitlePartnersCtr.clear();
    createDescriptionPartnersCtr.clear();
    createSacrificePartner = 8;
    createSacrificeTypeItem = ServiceTypeModel(
      name: "حاشي",
      serviceTypeId: 1,
    );
    update();
  }

  int createSacrificePartner = 8;
  changeCreateSacrificePartnerState(int val) {
    createSacrificePartner = val;
    update();
  }

  ServiceTypeModel createSacrificeTypeItem = ServiceTypeModel(
    name: "حاشي",
    serviceTypeId: 1,
  );

  changeCreateSacrificeTypeState(ServiceTypeModel val) {
    createSacrificeTypeItem = val;
    update();
  }
}
