import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الاشعارات'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'لا يوجد اشعارات حاليا',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
