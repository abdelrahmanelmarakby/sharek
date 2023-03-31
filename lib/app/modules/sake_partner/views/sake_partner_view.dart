import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sake_partner_controller.dart';

class SakePartnerView extends GetView<SakePartnerController> {
  const SakePartnerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SakePartnerView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SakePartnerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
