// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../constants/theme/colors_manager.dart';
import 'app_text.dart';

class AppExpansionTile extends StatelessWidget {
  const AppExpansionTile({
    Key? key,
    this.icon,
    required this.title,
    this.children,
  }) : super(key: key);
  final IconData? icon;
  final String title;
  final List<Widget>? children;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE4E4E5),
        ),
      ),
      width: double.infinity,
      child: ListTileTheme(
        dense: true,
        horizontalTitleGap: 10.0,
        minLeadingWidth: 0,
        child: ExpansionTile(
          leading: icon != null
              ? Icon(
                  icon,
                  color: Colors.black,
                )
              : null,
          title: AppText(
            title,
            fontSize: 16,
            color: ColorsManager.black,
          ),
          children: children ?? [],
        ),
      ),
    );
  }
}
