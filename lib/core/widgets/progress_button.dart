import 'package:flutter/material.dart';

import '../constants/theme/theme_export.dart';

class AppProgressButton extends StatefulWidget {
  final String? text;
  final Widget? child;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? progressIndicatorColor;
  final bool? isBordered;
  final Color? textColor;
  final double? fontSize;
  final double? radius;
  final double? elevation;
  final EdgeInsets? padding;
  final Function(AnimationController animationController) onPressed;

  const AppProgressButton({
    Key? key,
    required this.onPressed,
    this.text,
    this.child,
    this.width,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.isBordered,
    this.height = 50,
    this.progressIndicatorColor,
    this.radius = 5,
    this.elevation,
    this.padding,
  }) : super(key: key);

  @override
  State<AppProgressButton> createState() => AppProgressButtonState();
}

class AppProgressButtonState extends State<AppProgressButton>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> sizeAnimation;
  late Animation<BorderRadiusGeometry?> radiusAnimation;

  double buttonHeight = 50;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    buttonHeight = widget.height ?? 50;

    final curvedAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );

    sizeAnimation = Tween<double>(
      begin: widget.width ?? 150,
      end: buttonHeight,
    ).animate(curvedAnimation);

    radiusAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(widget.radius ?? 8.0),
      end: BorderRadius.circular(50),
    ).animate(curvedAnimation);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Container(
        constraints: BoxConstraints(minWidth: buttonHeight),
        width: sizeAnimation.value,
        height: buttonHeight,
        child: MaterialButton(
          padding: widget.padding ??
              const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
          elevation: widget.elevation ?? 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: radiusAnimation.value!,
            side: !(widget.isBordered ?? false)
                ? BorderSide.none
                : BorderSide(
                    color: widget.textColor ?? ColorsManager.primary,
                    width: 1,
                  ),
          ),
          color: widget.backgroundColor ?? ColorsManager.primary,
          onPressed: () async {
            if (controller.isCompleted) return;
            widget.onPressed(controller);
          },
          child: controller.isCompleted
              ? OverflowBox(
                  maxWidth: buttonHeight,
                  maxHeight: buttonHeight,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CircularProgressIndicator.adaptive(
                      strokeWidth: 1,
                      backgroundColor:
                          widget.progressIndicatorColor ?? ColorsManager.white,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        widget.textColor ?? ColorsManager.white,
                      ),
                    ),
                  ),
                )
              : FittedBox(
                  child: widget.child ??
                      Text(
                        widget.text ?? 'Click Me',
                        style: StylesManager.bold(
                          color: widget.textColor ?? ColorsManager.white,
                          fontSize: widget.fontSize ?? FontSize.large,
                        ),
                      ),
                ),
        ),
      ),
    );
  }
}
