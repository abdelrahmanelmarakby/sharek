import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/video_chat_controller.dart';

class VideoChatView extends GetView<VideoChatController> {
  const VideoChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VideoChatView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'VideoChatView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
