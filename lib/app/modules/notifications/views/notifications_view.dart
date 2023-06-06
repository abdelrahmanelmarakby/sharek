import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

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
        title: Text(
          'التنبيهات',
          style: StylesManager.semiBold(
            color: ColorsManager.primary,
            fontSize: FontSize.xlarge,
          ),
        ),
        centerTitle: false,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return controller.refreshNotifications();
        },
        child: FutureBuilder<NotificationsModel?>(
          future: controller.notifications,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final notification = snapshot.data?.data;
              return ListView.separated(
                itemCount: notification?.length ?? 0,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  var item = notification?[index];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Divider(
                        thickness: 1,
                        height: 1,
                      ),
                      ListTile(
                        tileColor: (item?.isRead == 1)
                            ? ColorsManager.white
                            : ColorsManager.selection.withOpacity(.2),
                        trailing: Text(
                          timeago
                              .format(
                                  DateTime.tryParse(
                                        item?.createdAt ?? "",
                                      ) ??
                                      DateTime.now(),
                                  locale: "ar")
                              .toString(),
                          style: StylesManager.light(),
                        ),
                        subtitle: Text(
                          item?.content ?? "",
                          style: const TextStyle(
                            color: ColorsManager.veryDarkGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        title: Text(
                          item?.title ?? "",
                          style: StylesManager.semiBold(
                              fontSize: FontSize.medium,
                              color: ColorsManager.charcoal),
                        ),
                        leading: SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: AppCachedNetworkImage(
                              imageUrl: item?.avatar ?? "",
                            ),
                          ),
                        ),
                      ),
                    ],
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
      ),
    );
  }
}
