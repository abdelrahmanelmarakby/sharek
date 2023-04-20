import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/core/extensions/export.dart';
import 'package:sharek/core/global/const.dart';

import '../../../../core/constants/theme/sizes_manager.dart';
import '../../../data/models/home_model.dart';
import '../../home/views/home_view.dart';
import '../../travel_partner/bindings/travel_partner_binding.dart';
import '../../travel_partner/views/travel_partner_details_screen.dart';
import '../controllers/profile_controller.dart';

class MyAdsScreen extends GetView<ProfileController> {
  const MyAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إعلاناتي'),
      ),
      body: ListView.separated(
        itemCount: 10,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        separatorBuilder: (context, index) =>
            Sizes.size8.h(context).heightSizedBox,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(
                () => const TravelPartnerDetailsScreen(id: 4),
                binding: TravelPartnerBinding(),
              );
            },
            child: AdCard(
              ad: NewAdvertisements(
                createdAt1: "الأن",
                createdAt2: "الأن",
                userName: "محمد أحمد",
                location: "جدة",
                neighborhood: "الريان",
                title: "مطعم أسماك للتقبيل",
                photos: [dummyImage],
              ),
            ),
          );
        },
      ),
    );
  }
}
