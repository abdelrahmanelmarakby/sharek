import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/app/modules/auth/controllers/auth_controller.dart';
import 'package:sharek/app/modules/auth/views/otp_verification.dart';
import 'package:sharek/app/modules/auth/views/sign_up.dart';
import 'package:sharek/core/constants/theme/sizes_manager.dart';
import 'package:sharek/core/constants/theme/theme_export.dart';
import 'package:sharek/core/extensions/num.dart';
import 'package:sharek/core/extensions/widget.dart';
import 'package:sharek/core/language/local_keys.dart';
import 'package:sharek/core/widgets/custom_text_field.dart';
import 'package:sharek/core/widgets/progress_button.dart';

class SignInView extends GetView<AuthController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalKeys.signIn.tr),
      ),
      body: Column(
        children: [
          100.h(context).heightSizedBox,
          CustomTextField(
            name: LocalKeys.phone,
            hint: LocalKeys.phone.tr,
            prefixIcon: const Icon(Iconsax.mobile4),
            validate: (String? number) {
              if (number!.length > 10 || number.length < 10) {
                return "رقم الهاتف يحب ان يكون ١٠ ارقام فقط";
              }

              return null;
            },
          ),
          32.h(context).heightSizedBox,
          AppProgressButton(
            width: context.width,
            text: "تسجيل الدخول",
            onPressed: (anim) {
              anim.forward();
              Future.delayed(1.seconds, () {
                anim.reverse();
              });
              Get.to(() => const OtpVerification(
                    signIn: true,
                  ));
            },
          ),
          Sizes.size26.h(context).heightSizedBox,
          GestureDetector(
            onTap: () {
              Get.to(() => const SignUpView());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ليس لديك حساب؟ ",
                  style: StylesManager.medium(
                      color: ColorsManager.lightGrey,
                      fontSize: FontSize.medium),
                ),
                Text(
                  "تسجيل",
                  style: StylesManager.bold(
                      color: ColorsManager.primary, fontSize: FontSize.medium),
                )
              ],
            ),
          )
        ],
      ).horizontalScreenPadding,
    );
  }
}
