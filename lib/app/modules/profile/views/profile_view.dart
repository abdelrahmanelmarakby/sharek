// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sharek/app/data/remote_data_source/profile_apis.dart';
import 'package:sharek/app/modules/profile/bindings/profile_binding.dart';
import 'package:sharek/core/constants/theme/colors_manager.dart';
import 'package:sharek/core/constants/theme/font_manager.dart';
import 'package:sharek/core/extensions/export.dart';
import 'package:sharek/core/global/const.dart';
import 'package:sharek/core/widgets/app_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/theme/sizes_manager.dart';
import '../../../data/models/profile_model.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_list_tile.dart';
import 'account_erification_request_screen.dart';
import 'edit_user_info_screen.dart';
import 'favorites_screen.dart';
import 'my_ads_screen.dart';
import 'notification_settings_screen.dart';

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
      body: RefreshIndicator(
        onRefresh: () {
          return Get.forceAppUpdate();
        },
        child: FutureBuilder<UserInfoModel?>(
          future: ProfileApis.getUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserInfoModel? userData = snapshot.data!;
              Get.log(userData.toString());
              return SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Sizes.size20.h(context).heightSizedBox,
                      ProfileHeader(
                        name: userData.data?.name ?? "",
                        userImage: userData.data?.avatar ?? dummyImage,
                      ),
                      Sizes.size8.h(context).heightSizedBox,
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              "إعدادت الحساب",
                              fontSize: Sizes.size16.h(context),
                              fontWeight: FontWeights.semiBold,
                              color: ColorsManager.primary,
                            ),
                            Sizes.size8.h(context).heightSizedBox,
                            ProfileListTile(
                              title: "معلومات شخصية",
                              onTap: () {
                                Get.to(
                                  () => const EditUserInfoScreen(),
                                  binding: ProfileBinding(),
                                );
                              },
                            ),
                            Sizes.size4.h(context).heightSizedBox,
                            ProfileListTile(
                              title: "إعلاناتي",
                              onTap: () {
                                Get.to(
                                  () => const MyAdsScreen(),
                                  binding: ProfileBinding(),
                                );
                              },
                            ),
                            Sizes.size4.h(context).heightSizedBox,
                            ProfileListTile(
                              title: "المفضلة",
                              onTap: () {
                                Get.to(
                                  () => const FavoritesScreen(),
                                  binding: ProfileBinding(),
                                );
                              },
                            ),
                            Sizes.size4.h(context).heightSizedBox,
                            ProfileListTile(
                              title: "إعدادت التنبيهات",
                              onTap: () {
                                Get.to(
                                  () => const NotificationSettingsScreen(),
                                  binding: ProfileBinding(),
                                );
                              },
                            ),
                            Sizes.size4.h(context).heightSizedBox,
                            ProfileListTile(
                              title: "طلب توثيق الحساب",
                              isLast: true,
                              onTap: () {
                                Get.to(
                                  () =>
                                      const AccountVerificationRequestScreen(),
                                  binding: ProfileBinding(),
                                );
                              },
                            ),
                            Sizes.size24.h(context).heightSizedBox,
                            AppText(
                              "الدعم",
                              fontSize: Sizes.size14.h(context),
                              fontWeight: FontWeights.medium,
                              color: ColorsManager.primary,
                            ),
                            ProfileListTile(
                              title: "تواصل معنا",
                              onTap: () {
                                launchUrl(
                                  Uri.parse("https://shreak.net"),
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                            ),
                            Sizes.size4.h(context).heightSizedBox,
                            ProfileListTile(
                              title: "معلومات عنا",
                              onTap: () {
                                launchUrl(
                                  Uri.parse("https://shreak.net"),
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                            ),
                            Sizes.size4.h(context).heightSizedBox,
                            ProfileListTile(
                              title: "الأحكام والشروط",
                              onTap: () {
                                launchUrl(
                                  Uri.parse(
                                      "https://shreak.net/privacy_policy"),
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                            ),
                            Sizes.size12.h(context).heightSizedBox,
                            GestureDetector(
                              onTap: () {
                                controller.logOut();
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
              );
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation(ColorsManager.primary),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
