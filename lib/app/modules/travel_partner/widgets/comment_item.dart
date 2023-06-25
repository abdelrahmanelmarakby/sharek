// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/network_image.dart';
import '../../../routes/app_pages.dart';
import '../../home/views/home_view.dart';

class CommentItemWidget extends StatelessWidget {
  const CommentItemWidget({
    Key? key,
    required this.image,
    required this.username,
    required this.createdAt,
    required this.comment,
    this.userId,
  }) : super(key: key);
  final String image;
  final String username;
  final String createdAt;
  final String comment;
  final int? userId;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 8),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: .5,
            color: ColorsManager.veryLightGrey,
          ),
        ),
        child: Row(
          children: [
            ClipOval(
              child: AppCachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                width: 55,
                height: 55,
                isCircular: true,
                isLoaderShimmer: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AdRowItem(
                        icon: Iconsax.user,
                        text: username,
                        onTap: () {
                          userId != null
                              ? Get.toNamed(
                                  Routes.ANOTHER_USER_PROFILE,
                                  arguments: {
                                    "userId": userId,
                                  },
                                )
                              : null;
                        },
                      ),
                      const SizedBox(width: 24),
                      AdRowItem(
                        icon: Iconsax.clock,
                        text: createdAt,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  AppText(
                    comment,
                    maxLines: 5,
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeights.regular,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
