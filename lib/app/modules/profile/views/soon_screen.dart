// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sharek/core/extensions/num.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/constants/theme/sizes_manager.dart';
import '../../../../core/widgets/app_text.dart';

class SoonScreen extends StatelessWidget {
  const SoonScreen({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: AppText(
          "قريبا",
          fontSize: Sizes.size24.h(context),
          fontWeight: FontWeights.medium,
          color: ColorsManager.black,
        ),
      ),
    );
  }
}
