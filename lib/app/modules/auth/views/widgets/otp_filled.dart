// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import 'package:sharek/core/constants/theme/theme_export.dart';
import 'package:sharek/core/extensions/num.dart';

class FilledRoundedPinPut extends StatefulWidget {
  const FilledRoundedPinPut({
    Key? key,
    this.onChanged,
  }) : super(key: key);
  final Function(String)? onChanged;
  @override
  FilledRoundedPinPutState createState() => FilledRoundedPinPutState();

  @override
  String toStringShort() => 'Rounded Filled';
}

class FilledRoundedPinPutState extends State<FilledRoundedPinPut> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  bool showError = false;

  @override
  Widget build(BuildContext context) {
    const length = 5;
    //const borderColor = Color.fromRGBO(114, 178, 238, 1);
    const errorColor = Colors.red;
    const fillColor = Color(0xffF7f7f9);
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 13.h(context)),
      textStyle: StylesManager.medium(fontSize: FontSize.large),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return Center(
      child: Pinput(
        length: length,
        controller: controller,
        focusNode: focusNode,
        errorTextStyle: const TextStyle(
          color: Colors.red,
        ),
        defaultPinTheme: defaultPinTheme,
        onCompleted: (pin) {
          setState(() => showError = pin != '5555');
        },
        validator: (v) {
          if (v.toString().isEmpty || v!.length != 5) {
            return "رمز تأكيد خاطئ! نرجو كتابة الرمز الصحيح";
          }
          return null;
        },
        onChanged: widget.onChanged,
        focusedPinTheme: defaultPinTheme.copyWith(
          height: 68,
          width: 64,
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(
              color: const Color(0xffE4E4E5),
            ),
          ),
        ),
        hapticFeedbackType: HapticFeedbackType.lightImpact,
        followingPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: const Color(0xffE4E4E5),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        disabledPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: const Color(0xffE4E4E5),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            border: Border.all(color: errorColor),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
