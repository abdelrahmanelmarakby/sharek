import 'package:flutter/material.dart';

import '../../../../core/global/var.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("معلومات عنا"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(child: Text(aboutUs)),
      ),
    );
  }
}
