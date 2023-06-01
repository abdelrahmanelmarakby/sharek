// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/app/data/remote_data_source/house_ads_apis.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../data/models/house_partners_model.dart';
import '../widgets/house_ads.dart';
import 'house_ads_details_screen.dart';

class HouseFilterResoult extends StatelessWidget {
  const HouseFilterResoult({
    Key? key,
    this.servicesTypeid,
    this.location,
    this.numberPartners,
    this.neighborhood,
    this.nationality,
  }) : super(key: key);
  final int? servicesTypeid;
  final String? location;
  final int? numberPartners;
  final String? neighborhood;
  final String? nationality;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نتائج التصفية'),
      ),
      body: FutureBuilder<HousePartnersModel?>(
        future: HousePartnerAPI.filterHouseAds(
          location: location,
          nationality: nationality,
          neighborhood: neighborhood,
          numberPartners: numberPartners,
          servicesTypeid: servicesTypeid,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16.0),
              itemCount: snapshot.data?.data?.length ?? 0,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                Data? ads = snapshot.data?.data?[index];
                return snapshot.data?.data?.isNotEmpty ?? false
                    ? GestureDetector(
                        onTap: () {
                          Get.to(
                            () => HousePartnerDetailsScreen(
                              id: ads?.advertisementId ?? 0,
                              isUserAds: false,
                            ),
                          );
                        },
                        child: HouseAdsItem(
                          ad: ads,
                        ),
                      )
                    : Center(
                        child: AppText(
                          snapshot.data?.message ?? "",
                          color: Colors.black,
                        ),
                      );
              },
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
