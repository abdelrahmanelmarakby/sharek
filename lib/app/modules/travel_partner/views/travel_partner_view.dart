import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/travel_partner_controller.dart';

class TravelPartnerView extends GetView<TravelPartnerController> {
  const TravelPartnerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TravelPartnerView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TravelPartnerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
