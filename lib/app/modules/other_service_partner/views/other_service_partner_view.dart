import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sharek/app/data/remote_data_source/other_services_partener_apis.dart';
import 'package:sharek/core/constants/theme/app_icons.dart';
import 'package:sharek/core/extensions/num.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/constants/theme/styles_manager.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../data/models/other_services_partener_model.dart';
import '../controllers/other_service_partner_controller.dart';
import '../widget/other_ads_item.dart';
import 'other_ads_details_screen.dart';

class OtherServicePartnerView extends GetView<OtherServicePartnerController> {
  const OtherServicePartnerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtherServicePartnerController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('أخرى'),
            centerTitle: true,
          ),
          body: RefreshIndicator(
            onRefresh: () {
              return Get.forceAppUpdate();
            },
            child: FutureBuilder<OtherServicesPartenerModel?>(
              future: OtherServicesPartenerAPIS.getOtherAds(
                controller.textSearch,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Data>? otherAds = snapshot.data?.data;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40.h(context),
                            child: CustomTextField(
                              name: "BusinessSearch",
                              hint: "ابحث هنا",
                              controller: controller.searchController,
                              prefixIcon: const Icon(SharekIcons.search_1),
                              onChange: controller.onChangedSearch,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "الاعلانات الجديدة",
                                style: StylesManager.bold(
                                  fontSize: FontSize.xlarge,
                                ),
                              ),
                              const SizedBox(height: 12),
                              otherAds?.isEmpty ?? false
                                  ? Center(
                                      child: AppText(
                                        snapshot.data?.message ?? "",
                                        color: Colors.black,
                                      ),
                                    )
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: otherAds?.length ?? 0,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(height: 8),
                                      itemBuilder: (context, index) {
                                        final ads = otherAds?[index];
                                        return snapshot
                                                    .data?.data?.isNotEmpty ??
                                                false
                                            ? GestureDetector(
                                                onTap: () {
                                                  Get.to(
                                                    () =>
                                                        OtherPartnerDetailsScreen(
                                                      id: ads?.advertisementId ??
                                                          0,
                                                      isUserAds: false,
                                                    ),
                                                  );
                                                },
                                                child: OtherAdsItem(
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
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
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
          ),
        );
      },
    );
  }
}
