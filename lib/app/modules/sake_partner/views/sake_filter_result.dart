import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/app/modules/sake_partner/views/sake_ads_details_screen.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../data/models/sarifice_ads_model.dart';
import '../../../data/remote_data_source/serifice_apis.dart';
import '../controllers/sake_partner_controller.dart';
import '../widgets/sake_item.dart';

class SakeFilterResultScreen extends GetView<SakePartnerController> {
  const SakeFilterResultScreen({
    super.key,
    this.servicesTypeid,
    this.location,
    this.neighborhood,
    this.sacrificeType,
    this.quantity,
  });
  final int? servicesTypeid;
  final String? location;
  final String? neighborhood;
  final String? sacrificeType;
  final String? quantity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نتائج التصفية'),
      ),
      body: FutureBuilder<SarificeAdsModel?>(
        future: SarificeAPIS.filterSerificeAds(
          servicesTypeid: servicesTypeid,
          sacrificeType: sacrificeType,
          location: location,
          neighborhood: neighborhood,
          quantity: quantity,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data?.data;
            return data?.isNotEmpty ?? false
                ? ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: snapshot.data?.data?.length ?? 0,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      Data? ads = snapshot.data?.data?[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () => SakePartnerDetailsScreen(
                              id: ads?.advertisementId ?? 0,
                            ),
                          );
                        },
                        child: SakeAdsItem(
                          ad: ads,
                        ),
                      );
                    },
                  )
                : Center(
                    child: AppText(
                      snapshot.data?.message ?? "",
                      color: Colors.black,
                    ),
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation(ColorsManager.primary),
              ),
            );
          }
        },
      ),
    );
  }
}
