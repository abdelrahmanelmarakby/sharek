import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:sharek/app/modules/business_partner/views/business_partner_details_screen.dart';

import '../../../../core/constants/theme/theme_export.dart';
import '../../../../core/global/const.dart';
import '../../../../core/widgets/network_image.dart';
import '../../../data/models/notifications_model.dart';
import '../../../data/remote_data_source/notifications_apis.dart';
import '../../../routes/app_pages.dart';
import '../../business_partner/bindings/business_partner_binding.dart';
import '../../house_partner/bindings/house_partner_binding.dart';
import '../../house_partner/views/house_ads_details_screen.dart';
import '../../other_service_partner/bindings/other_service_partner_binding.dart';
import '../../other_service_partner/views/other_ads_details_screen.dart';
import '../../sake_partner/bindings/sake_partner_binding.dart';
import '../../sake_partner/views/sake_ads_details_screen.dart';
import '../../travel_partner/bindings/travel_partner_binding.dart';
import '../../travel_partner/views/travel_partner_details_screen.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'التنبيهات',
          style: StylesManager.semiBold(
            color: ColorsManager.black,
            fontSize: FontSize.xlarge,
          ),
        ),
                automaticallyImplyLeading: false,

        centerTitle: false,
      ),
      body: FutureBuilder<NotificationsModel?>(
        future: NotificationsAPI.getAllNotifications(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Center(
              child: Text(
                "برجاء تسجيل الدخول",
                style: StylesManager.medium(fontSize: FontSize.xXlarge),
              ),
            );
          }
          if (snapshot.hasData) {
            final notification = snapshot.data?.data ?? [];
            if (notification.isEmpty) {
              return Center(
                child: Text(
                  "لا توجد اشعارات",
                  style: StylesManager.medium(fontSize: FontSize.xXlarge),
                ),
              );
            }
            return ListView.builder(
              itemCount: notification.length,
              itemBuilder: (context, index) {
                var item = notification[index];
                return Slidable(
                  startActionPane: ActionPane(
                    motion: const BehindMotion(),
                    children: [
                      SlidableAction(
                        // An action can be bigger than the others.
                        flex: 1,

                        onPressed: (context) {
                          controller.deleteOneNotifcation(item.id ?? 0);
                        },
                        backgroundColor: ColorsManager.error,
                        foregroundColor: Colors.white,
                        icon: CupertinoIcons.delete,
                        label: 'مسح',
                      ),
                    ],
                  ), // The end action pane is the one at the right or the bottom side.
                  endActionPane: ActionPane(
                    motion: const BehindMotion(),
                    children: [
                      SlidableAction(
                        // An action can be bigger than the others.
                        flex: 1,
                        onPressed: (context) {
                          controller.deleteOneNotifcation(item.id ?? 0);
                        },
                        backgroundColor: ColorsManager.error,
                        foregroundColor: Colors.white,
                        icon: CupertinoIcons.delete,
                        label: 'مسح',
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Divider(
                        thickness: 1,
                        height: 1,
                      ),
                      ListTile(
                        onTap: () {
                          if (item.type == "sacrifice") {
                            Get.toNamed(
                              Routes.ANOTHER_USER_PROFILE,
                              arguments: {
                                "userId": item.senderId ?? 0,
                              },
                            );
                          } else {
                            if (item.type.toString() == "1") {
                              Get.to(
                                () => BusinessPartnerDetailsScreen(
                                  adId: item.advertisementId ?? 0,
                                  isUserAds: false,
                                ),
                                binding: BusinessPartnerBinding(),
                              );
                            } else if (item.type.toString() == "2") {
                              Get.to(
                                () => TravelPartnerDetailsScreen(
                                  id: item.advertisementId ?? 0,
                                  isUserAds: false,
                                ),
                                binding: TravelPartnerBinding(),
                              );
                            } else if (item.type.toString() == "3") {
                              Get.to(
                                () => SakePartnerDetailsScreen(
                                  id: item.advertisementId ?? 0,
                                  isUserAds: false,
                                ),
                                binding: SakePartnerBinding(),
                              );
                            } else if (item.type.toString() == "4") {
                              Get.to(
                                () => HousePartnerDetailsScreen(
                                  id: item.advertisementId ?? 0,
                                  isUserAds: false,
                                ),
                                binding: HousePartnerBinding(),
                              );
                            } else {
                              Get.to(
                                () => OtherPartnerDetailsScreen(
                                  id: item.advertisementId ?? 0,
                                  isUserAds: false,
                                ),
                                binding: OtherServicePartnerBinding(),
                              );
                            }
                          }
                        },
                        tileColor: (item.isRead == 1)
                            ? ColorsManager.white
                            : const Color(0xFFF4F4FF),
                        trailing: Text(
                          appTimeFormate(
                              DateTime.tryParse(item.createdAt ?? "") ??
                                  DateTime.now(),
                              "ar"),
                          style: StylesManager.light(),
                        ),
                        subtitle: Text(
                          item.content ?? "",
                          style: const TextStyle(
                            fontSize: 14,
                            color: ColorsManager.veryDarkGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        title: Text(
                          item.title ?? "",
                          style: StylesManager.bold(
                            fontSize: FontSize.large,
                            color: ColorsManager.charcoal,
                          ),
                        ),
                        leading: SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: AppCachedNetworkImage(
                              imageUrl: item.avatar ?? "",
                            ),
                          ),
                        ),
                      ),
                    ],
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
