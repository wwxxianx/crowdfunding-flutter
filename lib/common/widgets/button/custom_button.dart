import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:flutter/material.dart';

enum CustomButtonStyle {
  black,
  flatGreen,
  gradientGreen,
  white,
}

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final Color? color;
  final double height;
  final double elevation;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;
  final CustomButtonStyle style;
  final bool isLoading;
  final List<BoxShadow>? boxShadow;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.color,
    this.height = 50.0,
    this.elevation = 2.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.padding = const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
    this.textStyle = CustomFonts.titleMedium,
    this.style = CustomButtonStyle.gradientGreen,
    this.isLoading = false,
    this.boxShadow,
  }) : super(key: key);

  Color? _getBackgroundColor() {
    switch (style) {
      case CustomButtonStyle.flatGreen:
        return CustomColors.primaryGreen;
      case CustomButtonStyle.white:
        return Colors.white;
      case CustomButtonStyle.black:
        return Colors.black;
      case CustomButtonStyle.gradientGreen:
        return null;
      default:
        return Colors.transparent;
    }
  }

  Color _getForegroundColor() {
    switch (style) {
      case CustomButtonStyle.black:
        return CustomColors.primaryGreen;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _bgGradient = style == CustomButtonStyle.gradientGreen
        ? CustomColors.primaryGreenGradient
        : null;

    return Ink(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          gradient: _bgGradient,
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: borderRadius,
          boxShadow: boxShadow,
        ),
        child: FilledButton(
          onPressed: onPressed,
          child: isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    color: CustomColors.accentGreen,
                  ),
                )
              : child,
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(_getForegroundColor()),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
            padding: MaterialStateProperty.all(
              padding,
            ),
            textStyle: MaterialStateProperty.all(textStyle),
          ),
        ),
      ),
    );
  }
}
