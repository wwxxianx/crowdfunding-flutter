import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final bool isLoading;
  final bool enabled;
  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.isLoading = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: enabled ? onPressed : null,
      icon: isLoading
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: CustomColors.accentGreen,
              ),
            )
          : icon,
    );
  }
}
