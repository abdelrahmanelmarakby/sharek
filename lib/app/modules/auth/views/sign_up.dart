import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/app/modules/auth/controllers/auth_controller.dart';
import 'package:sharek/core/constants/theme/sizes_manager.dart';
import 'package:sharek/core/constants/theme/theme_export.dart';
import 'package:sharek/core/extensions/num.dart';
import 'package:sharek/core/extensions/widget.dart';
import 'package:sharek/core/language/local_keys.dart';
import 'package:sharek/core/widgets/custom_text_field.dart';
import 'package:sharek/core/widgets/progress_button.dart';

import '../../../../core/widgets/snack_bar.dart';

class SignUpView extends GetView<AuthController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalKeys.signUp.tr),
      ),
      body: Form(
        key: controller.registerFormKey,
        child: Column(
          children: [
            100.h(context).heightSizedBox,
            CustomTextField(
              name: LocalKeys.phone,
              hint: LocalKeys.phone.tr,
              controller: controller.registerPhoneCtr,
              prefixIcon: const Icon(Iconsax.mobile4),
              validate: (String? number) {
                if (number!.length > 9 || number.length < 9) {
                  return "رقم الهاتف يحب ان يكون ٩ ارقام فقط";
                }

                return null;
              },
            ),
            Sizes.size12.h(context).heightSizedBox,
            CustomTextField(
              name: LocalKeys.fullName,
              hint: "اسم المستخدم",
              controller: controller.registerNameCtr,
              prefixIcon: const Icon(Iconsax.user),
              validate: (String? value) {
                if (value!.isEmpty || value.length < 3) {
                  return "يجب ان يكون الاسم اكثر من ثلاث حروف";
                }
                return null;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GetBuilder<AuthController>(
                  builder: (controller) => Checkbox(
                    side: const BorderSide(
                      color: ColorsManager.primary,
                    ),
                    activeColor: ColorsManager.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: const BorderSide(
                        color: ColorsManager.primary,
                        width: .5,
                      ),
                    ),
                    value: controller.acceptedTermsAndCondtions,
                    onChanged: (value) {
                      controller.acceptedTermsAndCondtions = value!;
                      controller.update();
                    },
                  ),
                ),
                Text(
                  "اوافق علي الشروط والاحكام",
                  style: StylesManager.medium(
                    color: ColorsManager.black,
                    fontSize: FontSize.small,
                  ),
                ),
              ],
            ),
            Sizes.size20.h(context).heightSizedBox,
            AppProgressButton(
              width: context.width,
              text: "التسجيل ",
              onPressed: (anim) {
                if (controller.registerFormKey.currentState!.validate()) {
                  if (controller.acceptedTermsAndCondtions == true) {
                    controller.register(
                      phone: controller.registerPhoneCtr.text,
                      name: controller.registerNameCtr.text,
                      animationController: anim,
                    );
                  } else {
                    showSnackBar("يجب عليك الموافقة علي الشروط والاحكام");
                  }
                }
              },
            ),
            Sizes.size20.h(context).heightSizedBox,
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    " لديك حساب؟ ",
                    style: StylesManager.medium(
                        color: ColorsManager.lightGrey,
                        fontSize: FontSize.medium),
                  ),
                  Text(
                    "تسجيل الدخول",
                    style: StylesManager.bold(
                      color: ColorsManager.primary,
                      fontSize: FontSize.medium,
                    ),
                  )
                ],
              ),
            ),
          ],
        ).horizontalScreenPadding,
      ),
    );
  }
}
