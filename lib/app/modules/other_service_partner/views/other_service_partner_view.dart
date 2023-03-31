import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/other_service_partner_controller.dart';

class OtherServicePartnerView extends GetView<OtherServicePartnerController> {
  const OtherServicePartnerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OtherServicePartnerView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OtherServicePartnerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
