import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:flutter/material.dart';

enum IconButtonStyle {
  white,
  gradientGreen,
}

class CustomOutlinedIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  final IconButtonStyle style;
  final Border? border;

  const CustomOutlinedIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.style = IconButtonStyle.gradientGreen,
    this.border,
  });

  Color _getBackgroundColor() {
    switch (style) {
      case IconButtonStyle.white:
        return Colors.white;
      case IconButtonStyle.gradientGreen:
        return CustomColors.primaryGreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          gradient: style == IconButtonStyle.gradientGreen
              ? CustomColors.primaryGreenGradient
              : null,
          borderRadius: BorderRadius.circular(6.0),
          border: border ?? Border.all(
            color: Colors.black,
            width: 1.5,
          ),
        ),
        child: icon,
      ),
    );
  }
}
