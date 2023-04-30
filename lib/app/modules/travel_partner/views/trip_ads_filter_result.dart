import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/app/modules/travel_partner/views/travel_partner_details_screen.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../data/models/trip_ads_model.dart';
import '../../../data/remote_data_source/trip_ads.dart';
import '../controllers/travel_partner_controller.dart';
import '../widgets/trip_ads_item.dart';

class TripAdsFilterResult extends GetView<TravelPartnerController> {
  final int? servicesTypeid;
  final String? startingPlace;
  final int? numberPassengers;
  final String? endingPlace;
  final String? date;
  final String? time;
  final double? price;
  final bool? withPackages;
  final String? carType;
  final String? nationality;

  const TripAdsFilterResult({
    super.key,
    this.servicesTypeid,
    this.startingPlace,
    this.numberPassengers,
    this.endingPlace,
    this.date,
    this.time,
    this.price,
    this.withPackages,
    this.carType,
    this.nationality,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TripAdvertisementsModel?>(
      future: TripPartnerAPI.filterTripAds(
        servicesTypeid: servicesTypeid,
        date: date,
        carType: carType,
        withPackages: withPackages,
        endingPlace: endingPlace,
        numberPassengers: numberPassengers,
        price: price,
        startingPlace: startingPlace,
        time: time,
        nationality: nationality,
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
                              () => TravelPartnerDetailsScreen(
                                id: ads?.advertisementId ?? 0,
                                isUserAds: false,
                              ),
                            );
                          },
                          child: TripAdsItem(
                            ad: ads,
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
