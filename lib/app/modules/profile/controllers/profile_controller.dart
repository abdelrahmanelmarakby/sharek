import 'dart:developer';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sharek/app/data/remote_data_source/profile_apis.dart';

import '../../../../core/global/const.dart';
import '../../../../core/services/shared_prefs.dart';
import '../../../../core/widgets/snack_bar.dart';
import '../../../data/remote_data_source/favorites_and_report_apis.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  TextEditingController nameCtr = TextEditingController();
  TextEditingController phoneCtr = TextEditingController();
  Future updateUserAvatar() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    } else {
      BotToast.showLoading();
      final res = await ProfileApis.updateAvatar(image: File(pickedImage.path));
      if (res?.status == true) {
        Get.offAllNamed(Routes.BOTTOM_NAV_BAR);
        BotToast.closeAllLoading();
        showSnackBar(res?.message ?? "");
      } else {
        BotToast.closeAllLoading();
        showSnackBar(res?.message ?? "");
      }
    }
    update();
  }

  Future updateUserProfile({
    String? name,
    String? phone,
    required AnimationController animationController,
  }) async {
    animationController.forward();
    final res = await ProfileApis.updateProfile(name: name, phone: phone);
    if (res?.status == true) {
      animationController.forward();
      Future.delayed(1.seconds, () {
        animationController.reverse();
      });
      showSnackBar(res?.message ?? "");
      Get.forceAppUpdate();
      Get.offAllNamed(Routes.PROFILE);
    } else {
      animationController.reset();
      showSnackBar(res?.message ?? "");
    }
  }

  Future logOut() async {
    BotToast.showLoading();
    final res = await ProfileApis.logout();
    if (res?.status == true) {
      SharedPrefService(prefs: globalPrefs).removeToken();
      BotToast.closeAllLoading();
      showSnackBar(res?.message ?? "");
      Get.offAllNamed(Routes.AUTH);
    } else {
      BotToast.closeAllLoading();
      showSnackBar(res?.message ?? "");
    }
  }

  bool phoneNotifiCation = true;
  bool notifiCation = true;
  onChangePhoneNotifiCation(bool val) {
    phoneNotifiCation = val;
    update();
  }

  onChangeNotifiCation(bool val) {
    notifiCation = val;
    update();
  }

  Future addToFavorites({
    required int id,
  }) async {
    try {
      BotToast.showLoading();
      final res = await FavoritesAndReportAPIS.addToFavorites(
        type: Partners.businessAds,
        id: id,
      );
      if (res?.status == true) {
        Get.forceAppUpdate();
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
}
