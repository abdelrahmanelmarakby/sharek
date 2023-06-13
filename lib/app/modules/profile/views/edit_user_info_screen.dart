import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/core/extensions/export.dart';
import 'package:sharek/core/widgets/custom_text_field.dart';
import 'package:sharek/core/widgets/progress_button.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/sizes_manager.dart';
import '../../../data/models/profile_model.dart';
import '../../../data/remote_data_source/profile_apis.dart';
import '../controllers/profile_controller.dart';

class EditUserInfoScreen extends GetView<ProfileController> {
  const EditUserInfoScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('معلومات الحساب'),
      ),
      body: FutureBuilder<UserInfoModel?>(
        future: ProfileApis.getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data?.data;
            controller.nameCtr.text = data?.name ?? "";
            controller.phoneCtr.text = data?.phone.toString() ?? "";
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CustomTextField(
                          borderRadius: 8,
                          controller: controller.nameCtr,
                          hint: " ادخل اسم المستخدم ",
                          prefixIcon: const Icon(
                            Iconsax.user,
                          ),
                        ),
                        Sizes.size12.h(context).heightSizedBox,
                        CustomTextField(
                          name: "ادخل الرقم بدون صفر",
                          hint: "ادخل الرقم بدون صفر",
                          borderRadius: 8,
                          controller: controller.phoneCtr,
                          prefixIcon: const Icon(
                            Iconsax.call,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppProgressButton(
                    width: MediaQuery.of(context).size.width,
                    text: "حفظ",
                    onPressed: (anim) {
                      controller.updateUserProfile(
                        name: controller.nameCtr.text == ""
                            ? null
                            : controller.nameCtr.text,
                        phone: controller.phoneCtr.text == ""
                            ? null
                            : controller.phoneCtr.text,
                        animationController: anim,
                      );
                    },
                  )
                ],
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
    );
  }
}
