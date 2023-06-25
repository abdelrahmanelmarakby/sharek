// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/constants/theme/styles_manager.dart';
import '../../../../core/widgets/network_image.dart';
import '../../home/views/home_view.dart';

class TripAdsItem extends StatelessWidget {
  const TripAdsItem({
    Key? key,
    required this.ad,
  }) : super(key: key);
  final dynamic ad;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height / 6,
      width: context.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: .5, color: ColorsManager.veryLightGrey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      (ad?.title) ?? "",
                      overflow: TextOverflow.clip,
                      style: StylesManager.bold(fontSize: FontSize.large),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AdRowItem(
                          icon: Iconsax.clock,
                          text: ad?.createdAt1 ?? "",
                          maxLines: 2,
                        ),
                        AdRowItem(
                          icon: Iconsax.location,
                          text: ad?.startingPlace ?? "",
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AdRowItem(
                          icon: Iconsax.user,
                          text: ad?.userName ?? "",
                          maxLines: 2,
                        ),
                        AdRowItem(
                          icon: Iconsax.car,
                          text: ad?.carType ?? "راكب",
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AppCachedNetworkImage(
                    imageUrl: ad?.photos?[0] ?? "",
                    height: context.width / 4,
                    width: context.width / 4,
                    fit: BoxFit.cover,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
