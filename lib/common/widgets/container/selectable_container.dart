import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:flutter/material.dart';

class SelectableContainer extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Widget child;
  const SelectableContainer({
    super.key,
    this.margin,
    required this.isSelected,
    required this.onTap,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: isSelected ? CustomColors.containerLightGreen : Colors.white,
          border: Border.all(
            color:
                isSelected ? CustomColors.accentGreen : const Color(0xFFE9E9E9),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(6),
          boxShadow: isSelected
              ? [
                  const BoxShadow(
                    blurRadius: 7.5,
                    offset: Offset(0, 2),
                    color: CustomColors.primaryGreen,
                  )
                ]
              : null,
        ),
        child: Opacity(
          opacity: isSelected ? 1 : 0.6,
          child: child,
        ),
      ),
    );
  }
}
