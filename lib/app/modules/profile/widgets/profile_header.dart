// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:sharek/core/constants/theme/sizes_manager.dart';
import 'package:sharek/core/extensions/export.dart';
import 'package:sharek/core/widgets/network_image.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/widgets/app_text.dart';
import '../controllers/profile_controller.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
    this.userImage,
  }) : super(key: key);
  final String? userImage;
  @override
  Widget build(BuildContext context) {
    final ProfileController controller =
        Get.put<ProfileController>(ProfileController());

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              controller.updateUserAvatar();
            },
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  height: 96,
                  width: 96,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF7F7F9),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: userImage == null
                      ? SvgPicture.asset(
                          "assets/images/profile.svg",
                          color: ColorsManager.primary,
                          height: 40,
                          width: 40,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: AppCachedNetworkImage(
                            imageUrl: userImage!,
                            height: 96,
                            width: 96,
                          ),
                        ),
                ),
                Container(
                  height: 32,
                  width: 32,
                  decoration: const BoxDecoration(
                    color: ColorsManager.primary,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Iconsax.camera,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
          Sizes.size8.h(context).heightSizedBox,
          AppText(
            "مصعب حسن",
            fontSize: Sizes.size16.h(context),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
