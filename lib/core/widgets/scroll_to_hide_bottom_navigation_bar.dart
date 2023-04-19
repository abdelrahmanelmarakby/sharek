// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollToHideBottomNavigationBar extends StatelessWidget {
  ScrollController scrollController;
  Curve curves;
  List<Widget> children;
  Duration duration;
  ScrollToHideBottomNavigationBar({
    Key? key,
    required this.scrollController,
    this.curves = Curves.fastLinearToSlowEaseIn,
    required this.children,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        return AnimatedContainer(
          curve: curves,
          duration: duration,
          height: scrollController.position.userScrollDirection ==
                  ScrollDirection.reverse
              ? 0
              : kBottomNavigationBarHeight,
          child: child,
        );
      },
      child: Wrap(
        children: children,
      ),
    );
  }
}
