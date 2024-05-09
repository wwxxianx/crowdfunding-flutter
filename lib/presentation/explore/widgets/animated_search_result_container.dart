import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class AnimatedSearchResultContainer extends StatefulWidget {
  final Animation<double> scaleAnimation;
  const AnimatedSearchResultContainer({
    super.key,
    required this.scaleAnimation,
  });

  @override
  State<AnimatedSearchResultContainer> createState() =>
      _AnimatedSearchResultContainerState();
}

class _AnimatedSearchResultContainerState
    extends State<AnimatedSearchResultContainer>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: widget.scaleAnimation,
      child: Container(
        width: MediaQuery.of(context).size.width -
            (Dimensions.screenHorizontalPadding),
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        constraints: const BoxConstraints(minHeight: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Default
            Row(
              children: [
                const HeroIcon(
                  HeroIcons.sparkles,
                  style: HeroIconStyle.solid,
                  size: 20,
                  color: CustomColors.textGrey,
                ),
                4.kW,
                Text(
                  "Recommendation:",
                  style: CustomFonts.labelMedium.copyWith(
                    color: CustomColors.textGrey,
                  ),
                ),
              ],
            ),
            8.kH,
            Text(
              "Search by campaign title:",
              style: CustomFonts.bodyMedium.copyWith(
                color: CustomColors.textGrey,
              ),
            ),
            Text(
              "E.g.,  Green initiative / Help kelvin survive",
              style: CustomFonts.bodyMedium.copyWith(
                color: CustomColors.textGrey,
              ),
            ),
            18.kH,
            Text(
              "Search by campaign organizer:",
              style: CustomFonts.bodyMedium.copyWith(
                color: CustomColors.textGrey,
              ),
            ),
            Text(
              "E.g.,  Bill Gates Foundation",
              style: CustomFonts.bodyMedium.copyWith(
                color: CustomColors.textGrey,
              ),
            ),
            18.kH,
            RichText(
              text: TextSpan(
                text: "Tips: Use the filter to search by ",
                style: CustomFonts.bodyMedium.copyWith(
                  color: CustomColors.textGrey,
                ),
                children: [
                  TextSpan(
                    text: "location / category",
                    style: CustomFonts.titleMedium.copyWith(
                      color: CustomColors.textGrey,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
