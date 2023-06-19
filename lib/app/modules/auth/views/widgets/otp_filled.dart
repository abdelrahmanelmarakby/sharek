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
    const length = 4;
    //const borderColor = Color.fromRGBO(114, 178, 238, 1);
    const errorColor = Colors.red;
    const fillColor = Color(0xffF7f7f9);
    final defaultPinTheme = PinTheme(
      width: 64,
      height: 64,
      //margin: EdgeInsets.symmetric(horizontal: 13.h(context)),
      textStyle: StylesManager.medium(fontSize: FontSize.large),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.h(context)),
      child: Center(
        child: Pinput(
          length: length,
          listenForMultipleSmsOnAndroid: true,
          keyboardType: TextInputType.number,
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
            if (v.toString().isEmpty || v!.length != 4) {
              return "رمز تأكيد خاطئ! نرجو كتابة الرمز الصحيح";
            }
            return null;
          },
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          onChanged: widget.onChanged,
          focusedPinTheme: defaultPinTheme.copyWith(
            height: 64,
            width: 64,
            decoration: defaultPinTheme.decoration!.copyWith(
              border: Border.all(
                color: ColorsManager.success,
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
      ),
    );
  }
}
