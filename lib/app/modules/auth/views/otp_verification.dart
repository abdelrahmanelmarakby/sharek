import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sharek/app/modules/auth/controllers/auth_controller.dart';
import 'package:sharek/app/routes/app_pages.dart';
import 'package:sharek/core/constants/theme/sizes_manager.dart';
import 'package:sharek/core/constants/theme/theme_export.dart';
import 'package:sharek/core/extensions/num.dart';
import 'package:sharek/core/extensions/widget.dart';
import 'package:sharek/core/language/local_keys.dart';
import 'package:sharek/core/widgets/progress_button.dart';

import 'widgets/otp_filled.dart';

class OtpVerification extends GetView<AuthController> {
  const OtpVerification({
    super.key,
    required this.signIn,
  });
  final bool signIn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(signIn ? LocalKeys.signIn.tr : LocalKeys.signUp.tr),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          100.h(context).heightSizedBox,
          Text(
            " ادخل كود التفعيل",
            style: StylesManager.bold(fontSize: FontSize.xlarge),
          ),
          4.h(context).heightSizedBox,
          const FilledRoundedPinPut(),
          32.h(context).heightSizedBox,
          AppProgressButton(
            width: context.width,
            text: signIn ? LocalKeys.signIn.tr : LocalKeys.signUp.tr,
            onPressed: (anim) {
              anim.forward();
              Future.delayed(1.seconds, () {
                anim.reverse();
              });
              Get.offAndToNamed(Routes.BOTTOM_NAV_BAR);
            },
          ),
          Sizes.size26.h(context).heightSizedBox,
        ],
      ).horizontalScreenPadding,
    );
  }
}
