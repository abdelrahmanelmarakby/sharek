// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/core/constants/theme/colors_manager.dart';
import '../add_ads_sheet.dart';
import '../controllers/bottom_nav_bar_controller.dart';

class BottomNavBarView extends GetView<BottomNavBarController> {
  const BottomNavBarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavBarController>(
      builder: (controller) => Scaffold(
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: controller.CurrentScreen,
        bottomNavigationBar: _bottomNavigationBar(context),
        resizeToAvoidBottomInset: true,
      ),
    );
  }

  _bottomNavigationBar(BuildContext context) {
    return GetBuilder<BottomNavBarController>(
      builder: (controller) => BottomNavigationBar(
        elevation: 0,
        enableFeedback: true,
        selectedIconTheme:
            const IconThemeData(color: ColorsManager.primary, size: 25),
        unselectedItemColor: ColorsManager.darkGrey,
        backgroundColor: const Color(0xffF7F7F9),
        currentIndex: controller.getNavIndex,
        onTap: (index) => controller.onSelected(index),
        selectedItemColor: ColorsManager.primary,
        unselectedIconTheme:
            const IconThemeData(color: ColorsManager.darkGrey, size: 18),
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(
                Iconsax.home,
              ),
              label: "الرئيسية"),
          const BottomNavigationBarItem(
            icon: Icon(
              Iconsax.notification_bing,
            ),
            label: "الاشعارات",
          ),
          BottomNavigationBarItem(
            icon: FloatingActionButton(
              onPressed: () {
                Get.bottomSheet(
                  const AddAdsSheet(),
                  backgroundColor: Colors.white,
                );
              },
              elevation: 0,
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
            label: "",
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Iconsax.sms,
            ),
            label: "الرسائل",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/profile.svg",
              width: controller.getNavIndex == 4 ? 30 : 24,
              height: controller.getNavIndex == 4 ? 30 : 24,
              color: controller.getNavIndex == 4
                  ? ColorsManager.primary
                  : ColorsManager.darkGrey,
            ),
            label: "حسابي",
          ),
        ],
      ),
    );
  }
}
