import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:flutter/material.dart';

class CustomTag extends StatelessWidget {
  final Widget? prefixIcon;
  final bool isOverlay;
  final String label;
  const CustomTag({
    super.key,
    this.prefixIcon,
    this.isOverlay = true,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final rightPadding = prefixIcon == null ? 8.0 : 10.0;
    final bgOpacity = isOverlay ? 0.6 : 1.0;

    return IntrinsicWidth(
      child: Container(
        padding: EdgeInsets.only(
          bottom: 6.0,
          top: 6.0,
          left: 8.0,
          right: rightPadding,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFE9E9E9).withOpacity(bgOpacity),
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Row(
          children: [
            prefixIcon != null ? prefixIcon! : const SizedBox(),
            prefixIcon != null ? const SizedBox(width: 4.0) : const SizedBox(),
            Text(
              label,
              style: CustomFonts.labelExtraSmall.copyWith(
                color: const Color(0xFF2F2F2F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
