import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/core/constants/theme/theme_export.dart';
import 'package:sharek/core/widgets/custom_dropdown.dart';
import 'package:sharek/core/widgets/progress_button.dart';

import '../controllers/business_partner_controller.dart';
import 'business_partner_view.dart';

class BussinessPartnerFilterScreen extends GetView<BusinessPartnerController> {
  const BussinessPartnerFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تصفية'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const FiltersList(),
                    const SizedBox(height: 12),
                    AppDropDown(
                      title: "المنطقة",
                      icon: const Icon(
                        Iconsax.location,
                        color: Colors.black,
                      ),
                      bottomSheet: Container(),
                    ),
                    const SizedBox(height: 12),
                    AppDropDown(
                        icon: const Icon(
                          Iconsax.location_tick,
                          color: Colors.black,
                        ),
                        title: "المدينة",
                        bottomSheet: Container()),
                    const SizedBox(height: 12),
                    AppDropDown(
                        icon: SvgPicture.asset("assets/images/buildings.svg"),
                        title: "الحي",
                        bottomSheet: Container()),
                    const SizedBox(height: 12),
                    AppDropDown(
                      icon: const RotatedBox(
                        quarterTurns: 2,
                        child: Icon(
                          Iconsax.happyemoji,
                          color: ColorsManager.black,
                        ),
                      ),
                      title: "النوع",
                      bottomSheet: Container(),
                    ),
                  ],
                ),
              ),
            ),
            AppProgressButton(
              width: context.width,
              onPressed: (anim) {},
              backgroundColor: ColorsManager.primary,
              child: Text(
                "تصفية",
                style: StylesManager.medium(
                    fontSize: FontSize.large, color: ColorsManager.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
