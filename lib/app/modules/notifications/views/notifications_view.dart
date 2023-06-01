import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/constants/theme/theme_export.dart';
import '../../../../core/widgets/network_image.dart';
import '../../../data/models/notifications_model.dart';
import '../controllers/notifications_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('التنبيهات',
              style: StylesManager.semiBold(
                  color: ColorsManager.primary, fontSize: FontSize.xlarge)),
          centerTitle: false,
        ),
        body: FutureBuilder<NotificationsModel?>(
          future: controller.notifications,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final notification = snapshot.data;
              if (notification?.data?.isEmpty ?? true) {
                return const Center(
                  child: Text("لا توجد اشعارات جديدة"),
                );
              }
              return SizedBox(
                height: context.height,
                child: Column(
                    children: List.generate(
                        notification?.data?.length ?? 0,
                        (index) => Column(children: [
                              const Divider(
                                thickness: 1,
                                height: 1,
                              ),
                              ListTile(
                                tileColor: (notification?.data?[index].isRead ==
                                        1)
                                    ? ColorsManager.white
                                    : ColorsManager.selection.withOpacity(.2),
                                trailing: Text(
                                  timeago
                                      .format(
                                          DateTime.tryParse(notification
                                                      ?.data?[index]
                                                      .createdAt ??
                                                  "") ??
                                              DateTime.now(),
                                          locale: "ar")
                                      .toString(),
                                  style: StylesManager.light(),
                                ),
                                subtitle: Text(
                                  notification?.data?[index].content ?? "",
                                  style: const TextStyle(
                                      color: ColorsManager.veryDarkGrey,
                                      fontWeight: FontWeight.w500),
                                ),
                                title: Text(
                                  notification?.data?[index].title ?? "",
                                  style: StylesManager.semiBold(
                                      fontSize: FontSize.medium,
                                      color: ColorsManager.charcoal),
                                ),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: AppCachedNetworkImage(
                                    imageUrl:
                                        notification?.data?[index].avatar ?? "",
                                  ),
                                ),
                              )
                            ]))),
              );
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ));
  }
}
