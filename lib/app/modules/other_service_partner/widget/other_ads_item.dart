// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:sharek/app/data/models/other_services_partener_model.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/constants/theme/styles_manager.dart';
import '../../../../core/global/const.dart';
import '../../home/views/home_view.dart';

class OtherAdsItem extends StatelessWidget {
  const OtherAdsItem({
    Key? key,
    required this.ad,
  }) : super(key: key);
  final Data? ad;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height / 6,
      width: context.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: .5,
          color: ColorsManager.veryLightGrey,
        ),
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
                      children: [
                        AdRowItem(
                          icon: Iconsax.clock,
                          text: ad?.createdAt1 ?? "",
                        ),
                        AdRowItem(
                          icon: Iconsax.location,
                          text: ad?.location ?? "",
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AdRowItem(
                          icon: Iconsax.user,
                          text: ad?.userName ?? "",
                        ),
                        AdRowItem(
                          icon: Iconsax.routing,
                          text: ad?.neighborhood ?? "",
                        )
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
                    ad?.photos?.isNotEmpty ?? false
                        ? ad?.photos?.first ?? ""
                        : dummyImage,
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
