import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/house_partner_controller.dart';

class HousePartnerView extends GetView<HousePartnerController> {
  const HousePartnerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HousePartnerView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HousePartnerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
