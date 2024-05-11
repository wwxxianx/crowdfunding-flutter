import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class TipsButton extends StatelessWidget {
  final VoidCallback onPressed;
  const TipsButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      boxShadow: CustomColors.containerLightShadow,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 34,
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const HeroIcon(
            HeroIcons.sparkles,
            style: HeroIconStyle.solid,
            size: 18,
            color: Color(0xFF06730C),
          ),
          4.kW,
          Text(
            "Tips",
            style: CustomFonts.titleExtraSmall.copyWith(
              color: const Color(0xFF014004),
            ),
          ),
        ],
      ),
    );
  }
}
