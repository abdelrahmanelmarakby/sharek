// ignore_for_file: avoid_print

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/global/const.dart';
import '../../../../core/services/get_storage_helper.dart';
import '../../../../core/services/shared_prefs.dart';
import '../../../../core/widgets/snack_bar.dart';
import '../../../data/remote_data_source/auth_apis.dart';
import '../../../routes/app_pages.dart';
import '../views/otp_verification.dart';

class AuthController extends GetxController {
  bool acceptedTermsAndCondtions = false;
  TextEditingController loginPhoneCtr = TextEditingController();
  TextEditingController registerPhoneCtr = TextEditingController();
  TextEditingController registerNameCtr = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();

  String otp = "";
  void onChangeOtp(String val) {
    otp = val;
    update();
  }

  Future login({
    required String phone,
    required AnimationController animationController,
  }) async {
    animationController.forward();
    final res = await AuthApis.login(phone: phone);
    if (res?.status == true) {
      animationController.forward();
      Future.delayed(1.seconds, () {
        animationController.reverse();
      });
      showSnackBar(res?.message ?? "");
      Get.to(() => OtpVerification(signIn: true, phone: phone));
    } else {
      showSnackBar(res?.message ?? 'حدث خطآ ما'.tr);
      animationController.reset();
    }
  }

  Future register({
    required String phone,
    required String name,
    required AnimationController animationController,
  }) async {
    animationController.forward();
    final res = await AuthApis.register(phone: phone, name: name);
    if (res?.status == true) {
      animationController.forward();
      Future.delayed(1.seconds, () {
        animationController.reverse();
      });
      showSnackBar(res?.message ?? "");
      Get.to(() => OtpVerification(signIn: false, phone: phone));
    } else {
      showSnackBar(res?.message ?? 'حدث خطآ ما'.tr);
      animationController.reset();
    }
  }

  Future registerOtp({
    required String phone,
    required String code,
    required AnimationController animationController,
  }) async {
    animationController.forward();
    final res = await AuthApis.registerOtp(phone: phone, code: code);

    CacheHelper.cacheUserId(id: res!.data!.user!.id!);
    if (res.status == true) {
      animationController.forward();
      print(res.data?.user?.id);

      await Future.delayed(300.milliseconds, () {
        animationController.reset();
      });
      showSnackBar(res.message ?? "");
      SharedPrefService(prefs: globalPrefs).saveToken(res.data?.token ?? '');
      Get.offAndToNamed(Routes.BOTTOM_NAV_BAR);
    } else {
      showSnackBar(res.message ?? 'حدث خطآ ما'.tr);
      animationController.reset();
    }
  }

  Future loginOtp({
    required String phone,
    required String code,
    required AnimationController animationController,
  }) async {
    animationController.forward();
    final res = await AuthApis.loginOtp(phone: phone, code: code);

    if (res?.status == true) {
      animationController.forward();
      try {
        CacheHelper.cacheUserId(id: res?.data?.user?.id ?? 0);
      } catch (e) {
        showSnackBar(e.toString());
      }

      Get.log(res?.data?.user?.id.toString() ?? "");

      Future.delayed(1.seconds, () {
        animationController.reverse();
      });
      showSnackBar(res?.message ?? "");
      try {
        SharedPrefService(prefs: globalPrefs).saveToken(res?.data?.token ?? '');
      } catch (e) {
        showSnackBar(e.toString());
      }
      Get.offAllNamed(Routes.BOTTOM_NAV_BAR);
    } else {
      showSnackBar(res?.message ?? 'حدث خطآ ما'.tr);
      animationController.reset();
    }
  }
}
