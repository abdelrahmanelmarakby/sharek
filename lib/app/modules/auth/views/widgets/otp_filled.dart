import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sharek/core/constants/theme/theme_export.dart';

class FilledRoundedPinPut extends StatefulWidget {
  const FilledRoundedPinPut({Key? key}) : super(key: key);

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
    const errorColor = Color.fromRGBO(255, 234, 238, 1);
    const fillColor = Color(0xffF7f7f9);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: StylesManager.medium(fontSize: FontSize.large),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return Center(
      child: SizedBox(
        height: 68,
        child: Pinput(
          length: length,
          controller: controller,
          focusNode: focusNode,
          defaultPinTheme: defaultPinTheme,
          onCompleted: (pin) {
            setState(() => showError = pin != '5555');
          },
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
              color: errorColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
