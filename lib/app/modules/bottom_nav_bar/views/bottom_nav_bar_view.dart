import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/app/modules/home/views/home_view.dart';
import 'package:sharek/core/constants/theme/app_icons.dart';
import 'package:sharek/core/constants/theme/colors_manager.dart';
import 'package:sharek/core/constants/theme/font_manager.dart';
import 'package:sharek/core/constants/theme/styles_manager.dart';
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
                unselectedIconTheme: const IconThemeData(
                    color: ColorsManager.darkGrey, size: 18),
                type: BottomNavigationBarType.fixed,
                items: [
                  const BottomNavigationBarItem(
                      icon: Icon(
                        Iconsax.home,
                      ),
                      label: "الرئيسية"),
                  const BottomNavigationBarItem(
                      icon: Icon(
                        Iconsax.notification,
                      ),
                      label: "الاشعارات"),
                  BottomNavigationBarItem(
                      icon: FloatingActionButton(
                        onPressed: () {
                          Get.bottomSheet(
                              SizedBox(
                                height: context.height / 2.5,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Spacer(),
                                        Text(
                                          "اختر نوع الخدمة",
                                          style: StylesManager.semiBold(
                                            fontSize: FontSize.xlarge,
                                          ),
                                        ),
                                        const Spacer(),
                                        Wrap(
                                          runSpacing: 0,
                                          spacing: 0,
                                          alignment: WrapAlignment.start,
                                          children: const [
                                            PartnerCard(
                                              isDialog: true,
                                              name: "شريك اعمال",
                                              imagePath:
                                                  "assets/images/business_partner.svg",
                                              serviceId: 1,
                                            ),
                                            PartnerCard(
                                                isDialog: true,
                                                serviceId: 2,
                                                name: "شريك رحلتي",
                                                imagePath:
                                                    "assets/images/travel_partner.svg"),
                                            PartnerCard(
                                                isDialog: true,
                                                serviceId: 3,
                                                name: "شريك ذبيحتي",
                                                imagePath:
                                                    "assets/images/sake_partner.svg"),
                                            PartnerCard(
                                                isDialog: true,
                                                serviceId: 4,
                                                name: "شريك سكني",
                                                imagePath:
                                                    "assets/images/housing_partner.svg"),
                                            PartnerCard(
                                              isDialog: true,
                                              serviceId: 5,
                                              name: "اخري",
                                              imagePath:
                                                  "assets/images/business_partner.svg",
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                      ],
                                    )),
                              ),
                              backgroundColor: Colors.white);
                        },
                        elevation: 0,
                        child: const Icon(Icons.add),
                      ),
                      label: ""),
                  const BottomNavigationBarItem(
                      icon: Icon(
                        Iconsax.message,
                      ),
                      label: "الرسائل"),
                  const BottomNavigationBarItem(
                      icon: Icon(
                        SharekIcons.profile,
                      ),
                      label: "حسابي"),
                ]));
  }
}
