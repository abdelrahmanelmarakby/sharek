import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/another_user_profile_controller.dart';

class AnotherUserProfileView extends GetView<AnotherUserProfileController> {
  const AnotherUserProfileView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;

    var userId = arguments["userId"] ?? "";
    log(userId.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.only(right: 6),
            decoration: const BoxDecoration(
              color: Color(0xFFF7F7F9),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios,
                size: 18,
              ),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            child: Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(left: 8),
              decoration: const BoxDecoration(
                color: Color(0xFFF7F7F9),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Center(
                child: Icon(
                  Icons.share_outlined,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        
      ),
    );
  }
}
