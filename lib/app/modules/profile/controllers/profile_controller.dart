import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sharek/app/data/remote_data_source/profile_apis.dart';

import '../../../../core/global/const.dart';
import '../../../../core/services/shared_prefs.dart';
import '../../../../core/widgets/snack_bar.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  Future updateUserAvatar() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    } else {
      BotToast.showLoading();
      final res = await ProfileApis.updateAvatar(image: File(pickedImage.path));
      if (res?.status == true) {
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
    required String name,
    required String phone,
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
      Get.back();
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
}
