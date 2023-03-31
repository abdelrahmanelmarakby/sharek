import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:sharek/core/extensions/export.dart';

import 'sharek_utills.dart';

extension GetNumUtils on num {
  bool isLowerThan(num b) => SharekUtils.isLowerThan(this, b);

  bool isGreaterThan(num b) => SharekUtils.isGreaterThan(this, b);

  bool isEqual(num b) => SharekUtils.isEqual(this, b);

  /// Utility to delay some callback (or code execution).
  /// to stop it.
  ///
  /// Sample:
  /// ```
  /// void main() async {
  ///   print('+ wait for 2 seconds');
  ///   await 2.delay();
  ///   print('- 2 seconds completed');
  ///   print('+ callback in 1.2sec');
  ///   1.delay(() => print('- 1.2sec callback called'));
  ///   print('currently running callback 1.2sec');
  /// }
  ///```
  Future delay([FutureOr Function()? callback]) async => Future.delayed(
        Duration(milliseconds: (this * 1000).round()),
        callback,
      );
  Widget get heightSizedBox => SizedBox(
        height: toDouble(),
      );
  Widget percentHeightSizedBox(BuildContext context) => SizedBox(
        height: context.height * this,
      );
  Widget get widthSizedBox => SizedBox(
        width: toDouble(),
      );
  Widget percentWidthSizedBox(BuildContext context) => SizedBox(
        width: context.width * this,
      );

  double w(BuildContext context) => ((this / 390)) * context.width;
  double h(BuildContext context) => ((this / 844)) * context.height;
}
