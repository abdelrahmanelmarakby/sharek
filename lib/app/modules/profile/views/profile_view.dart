// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sharek/app/routes/app_pages.dart';
import 'package:sharek/core/constants/theme/colors_manager.dart';
import 'package:sharek/core/constants/theme/font_manager.dart';
import 'package:sharek/core/extensions/export.dart';
import 'package:sharek/core/widgets/app_text.dart';

import '../../../../core/constants/theme/sizes_manager.dart';
import '../../../../core/global/const.dart';
import '../../../../core/services/shared_prefs.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_list_tile.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حسابي'),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Sizes.size20.h(context).heightSizedBox,
              const ProfileHeader(),
              Sizes.size8.h(context).heightSizedBox,
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      "إعدادت الحساب",
                      fontSize: Sizes.size14.h(context),
                      fontWeight: FontWeights.medium,
                      color: ColorsManager.primary,
                    ),
                    Sizes.size8.h(context).heightSizedBox,
                    const ProfileListTile(
                      title: "معلومات شخصية",
                    ),
                    Sizes.size4.h(context).heightSizedBox,
                    const ProfileListTile(
                      title: "إعلاناتي",
                    ),
                    Sizes.size4.h(context).heightSizedBox,
                    const ProfileListTile(
                      title: "المفضلة",
                    ),
                    Sizes.size4.h(context).heightSizedBox,
                    const ProfileListTile(
                      title: "إعدادت التنبيهات",
                    ),
                    Sizes.size4.h(context).heightSizedBox,
                    const ProfileListTile(
                      title: "طلب توثيق الحساب",
                      isLast: true,
                    ),
                    Sizes.size24.h(context).heightSizedBox,
                    AppText(
                      "الدعم",
                      fontSize: Sizes.size14.h(context),
                      fontWeight: FontWeights.medium,
                      color: ColorsManager.primary,
                    ),
                    const ProfileListTile(
                      title: "تواصل معنا",
                    ),
                    Sizes.size4.h(context).heightSizedBox,
                    const ProfileListTile(
                      title: "معلومات عنا",
                    ),
                    Sizes.size4.h(context).heightSizedBox,
                    const ProfileListTile(
                      title: "الأحكام والشروط",
                    ),
                    Sizes.size24.h(context).heightSizedBox,
                    GestureDetector(
                      onTap: () {
                        SharedPrefService(prefs: globalPrefs).removeToken();
                        Get.offAllNamed(Routes.AUTH);
                      },
                      child: AppText(
                        "تسجيل الخروج",
                        fontSize: Sizes.size14.h(context),
                        fontWeight: FontWeights.medium,
                        color: ColorsManager.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
