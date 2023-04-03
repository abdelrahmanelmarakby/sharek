// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:sharek/app/data/models/trip_ads_model.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/constants/theme/styles_manager.dart';
import '../../home/views/home_view.dart';

class TripAdsItem extends StatelessWidget {
  const TripAdsItem({
    Key? key,
    required this.ad,
  }) : super(key: key);
  final Data? ad;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height / 7,
      width: context.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: .5, color: ColorsManager.veryLightGrey),
          color: const Color(
            0xffF7F7F9,
          )),
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
                      children: [
                        AdRowItem(
                            icon: Iconsax.clock, text: ad?.createdAt1 ?? ""),
                        AdRowItem(
                            icon: Iconsax.location,
                            text: ad?.startingPlace ?? "")
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AdRowItem(icon: Iconsax.user, text: ad?.userName ?? ""),
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
                fit: FlexFit.loose,
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    ad?.photos?[0] ?? "",
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
