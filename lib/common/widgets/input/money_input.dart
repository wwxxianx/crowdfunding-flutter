import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/widgets/input/outlined_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoneyTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const MoneyTextField({
    super.key,
    required this.controller,
    this.label = "Donation amount",
  });

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedTextfield(
      inputFormatters: [
        // Can not start with 0
        FilteringTextInputFormatter.deny(RegExp(r'^0')),
        // Only accept digit
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        FilteringTextInputFormatter.digitsOnly,
      ],
      contentPadding: const EdgeInsets.only(
        left: 12,
        right: 8,
        top: 8,
        bottom: 8,
      ),
      keyboardType: TextInputType.number,
      suffixIcon: const Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            ".00",
            style: CustomFonts.labelSmall,
          ),
        ],
      ),
      textAlign: TextAlign.end,
      controller: controller,
      label: label,
      prefixIcon: const Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "RM",
            style: CustomFonts.titleMedium,
          ),
        ],
      ),
    );
  }
}