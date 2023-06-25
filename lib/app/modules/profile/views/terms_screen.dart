import 'package:flutter/material.dart';

import '../../../../core/global/var.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الشروط و سياسة الخصوصية"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            terms,
          ),
        ),
      ),
    );
  }
}
