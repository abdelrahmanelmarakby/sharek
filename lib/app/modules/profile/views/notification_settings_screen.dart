import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/core/extensions/export.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/constants/theme/sizes_manager.dart';
import '../../../../core/global/const.dart';
import '../../../../core/services/shared_prefs.dart';
import '../../../../core/widgets/app_text.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_list_tile.dart';

class NotificationSettingsScreen extends GetView<ProfileController> {
  const NotificationSettingsScreen({
    super.key,
    required this.phone,
  });
  final String phone;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('إعدادت التطبيق'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                "التنبيهات",
                fontSize: Sizes.size12.h(context),
                fontWeight: FontWeights.medium,
                color: ColorsManager.primary,
              ),
              Sizes.size8.h(context).heightSizedBox,
              ProfileListTile(
                title: "رقم الجوال",
                trailing: Switch.adaptive(
                  activeColor: ColorsManager.primary,
                  inactiveTrackColor: ColorsManager.veryLightGrey,
                  value:
                      SharedPrefService(prefs: globalPrefs).loadIsPhoneStatus(),
                  onChanged: controller.onChangePhoneNotifiCation,
                ),
              ),
              Sizes.size16.h(context).heightSizedBox,
              ProfileListTile(
                title: "الإشعارات",
                trailing: Switch.adaptive(
                  activeColor: ColorsManager.primary,
                  inactiveTrackColor: ColorsManager.veryLightGrey,
                  value:
                      SharedPrefService(prefs: globalPrefs).loadIsNotiStatus(),
                  onChanged: controller.onChangeNotifiCation,
                ),
              ),
              Sizes.size8.h(context).heightSizedBox,
              AppText(
                "الحساب",
                fontSize: Sizes.size12.h(context),
                fontWeight: FontWeights.medium,
                color: ColorsManager.primary,
              ),
              ProfileListTile(
                title: "حذف الحساب",
                isLast: true,
                color: ColorsManager.red2,
                onTap: () {
                  controller.deleteAccount(phone: phone);
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
