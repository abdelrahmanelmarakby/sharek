// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sharek/core/constants/theme/colors_manager.dart';

import 'package:sharek/core/extensions/export.dart';

import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/constants/theme/styles_manager.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    Key? key,
    this.onTap,
    required this.title,
    this.isLast = false,
    this.color = ColorsManager.charcoal,
    this.trailing,
  }) : super(key: key);
  final Function()? onTap;
  final String title;
  final bool? isLast;
  final Widget? trailing;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 35.h(context),
          child: ListTile(
            minVerticalPadding: 0,
            onTap: onTap,
            contentPadding: EdgeInsets.zero,
            trailing: trailing ??
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF7D848D),
                ),
            title: Text(
              title,
              style: StylesManager.regular(
                color: color,
                fontSize: FontSize.large.h(context),
              ),
            ),
          ),
        ),
        isLast == true
            ? const SizedBox()
            : const Divider(color: Color(0xFFF7F7F9)),
      ],
    );
  }
}
