import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/app/data/models/business_ads_model.dart';
import 'package:sharek/app/data/models/home_model.dart';
import 'package:sharek/app/data/remote_data_source/business_ads.dart';
import 'package:sharek/app/modules/business_partner/controllers/business_partner_controller.dart';
import 'package:sharek/app/modules/home/views/home_view.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/widgets/app_text.dart';
import 'business_partner_details_screen.dart';

class BusinessAdsFilterResult extends GetView<BusinessPartnerController> {
  final int? servicesTypeid;
  final String? city;
  final String? location;
  final int? type;

  const BusinessAdsFilterResult({
    super.key,
    this.servicesTypeid,
    this.city,
    this.location,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BusinessPartnerModel?>(
      future: BusinessPartnerAPI.filterBusinessAds(
        servicesTypeid: servicesTypeid,
        city: city,
        location: location,
        type: type,
      ),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('نتائج التصفية'),
          ),
          body: snapshot.hasData
              ? (snapshot.data?.data?.isNotEmpty ?? false
                  ? ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: snapshot.data?.data?.length ?? 0,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final ads = snapshot.data?.data?[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () => BusinessPartnerDetailsScreen(
                                adId: ads?.advertisementId ?? 0,
                                isUserAds: false,
                              ),
                            );
                          },
                          child: AdCard(
                            ad: NewAdvertisements(
                              title: ads?.title,
                              advertisementId: ads?.advertisementId,
                              createdAt1: ads?.createdAt1,
                              createdAt2: ads?.createdAt2,
                              userName: ads?.userName,
                              location: ads?.location,
                              neighborhood: ads?.neighborhood,
                              photos: ads?.photos,
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: AppText(
                        "لا يوجد اعلانات مطابقة للبحث",
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeights.medium,
                      ),
                    ))
              : const Center(
                  child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation(ColorsManager.primary),
                  ),
                ),
        );
      },
    );
  }
}
