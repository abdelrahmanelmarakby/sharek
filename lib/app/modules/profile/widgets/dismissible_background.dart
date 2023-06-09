import 'package:flutter/material.dart';

import '../../../../core/constants/theme/colors_manager.dart';

class DismissibleBackground extends StatelessWidget {
  const DismissibleBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorsManager.red2,
      ),
      alignment: AlignmentDirectional.centerStart,
      child: const Padding(
        padding: EdgeInsets.only(right: 20.0, left: 20),
        child: Icon(
          Icons.delete_outline,
          color: Colors.white,
        ),
      ),
    );
  }
}
