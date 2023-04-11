import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/core/extensions/export.dart';
import 'package:sharek/core/widgets/custom_text_field.dart';
import 'package:sharek/core/widgets/progress_button.dart';

import '../../../../core/constants/theme/sizes_manager.dart';
import '../controllers/profile_controller.dart';

class EditUserInfoScreen extends GetView<ProfileController> {
  const EditUserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('معلومات الحساب'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const CustomTextField(
                    borderRadius: 8,
                    hint: "نبيل الصاوي",
                    prefixIcon: Icon(
                      Iconsax.user,
                    ),
                  ),
                  Sizes.size12.h(context).heightSizedBox,
                  const CustomTextField(
                    hint: "01091273822",
                    borderRadius: 8,
                    prefixIcon: Icon(
                      Iconsax.call,
                    ),
                  ),
                ],
              ),
            ),
            AppProgressButton(
              width: MediaQuery.of(context).size.width,
              text: "حفظ",
              onPressed: (anim) {},
            )
          ],
        ),
      ),
    );
  }
}
