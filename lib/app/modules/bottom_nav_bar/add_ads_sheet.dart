import 'package:flutter/material.dart';

import '../../../core/constants/theme/font_manager.dart';
import '../../../core/constants/theme/styles_manager.dart';
import '../home/views/home_view.dart';
import 'package:get/get.dart';

class AddAdsSheet extends StatelessWidget {
  const AddAdsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height / 2.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              "اختر نوع الخدمة",
              style: StylesManager.semiBold(
                fontSize: FontSize.xlarge,
              ),
            ),
            const Spacer(),
            const Wrap(
              runSpacing: 16,
              spacing: 0,
              alignment: WrapAlignment.start,
              children: [
                PartnerCard(
                  isDialog: true,
                  name: "شريك اعمال",
                  imagePath: "assets/images/business_partner.svg",
                  serviceId: 1,
                ),
                PartnerCard(
                    isDialog: true,
                    serviceId: 2,
                    name: "شريك رحلتي",
                    imagePath: "assets/images/travel_partner.svg"),
                PartnerCard(
                    isDialog: true,
                    serviceId: 3,
                    name: "شريك ذبيحتي",
                    imagePath: "assets/images/sake_partner.svg"),
                PartnerCard(
                    isDialog: true,
                    serviceId: 4,
                    name: "شريك سكني",
                    imagePath: "assets/images/housing_partner.svg"),
                PartnerCard(
                  isDialog: true,
                  serviceId: 5,
                  name: "شراكات اخرى",
                  imagePath: "assets/images/bubble.svg",
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
