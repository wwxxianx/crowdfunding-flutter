import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget? title;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback onTap;
  final EdgeInsetsGeometry padding;

  const CustomListTile({
    super.key,
    required this.title,
    required this.leading,
    required this.trailing,
    required this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        padding: padding,
        child: Row(
          children: [
            if (leading != null) leading!,
            if (leading != null) 8.kW,
            if (title != null) title!,
            const Spacer(),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
