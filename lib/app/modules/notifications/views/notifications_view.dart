import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/constants/theme/theme_export.dart';
import '../../../../core/widgets/network_image.dart';
import '../../../data/models/notifications_model.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('التنبيهات'),
          centerTitle: true,
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
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: (notification?.data?[index].isRead == 0)
                        ? ColorsManager.white
                        : ColorsManager.selection.withOpacity(.2),
                    subtitle: Text(notification?.data?[index].content ?? ""),
                    title: Text(notification?.data?[index].title ?? ""),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: AppCachedNetworkImage(
                        imageUrl: notification?.data?[index].avatar ?? "",
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ));
  }
}
