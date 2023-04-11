import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/core/constants/theme/sizes_manager.dart';
import 'package:sharek/core/extensions/export.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/widgets/app_text.dart';
import '../controllers/profile_controller.dart';

class AccountVerificationRequestScreen extends GetView<ProfileController> {
  const AccountVerificationRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طلب توثيق الحساب'),
      ),
      body: Center(
        child: AppText(
          "قريبا",
          fontSize: Sizes.size24.h(context),
          fontWeight: FontWeights.medium,
          color: ColorsManager.black,
        ),
      ),
    );
  }
}
