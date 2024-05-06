import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:material_symbols_icons/symbols.dart';

class CampaignAboutTabContent extends StatelessWidget {
  const CampaignAboutTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.screenHorizontalPadding,
        vertical: 16.0,
      ),
      child: Column(
        children: [
          // Organizer
          Row(
            children: [
              Icon(
                Symbols.account_balance_rounded,
                weight: 600,
              ),
              6.kW,
              Text(
                "Organizer",
                style: CustomFonts.titleMedium,
              ),
            ],
          ),
          12.kH,
          Row(
            children: [
              Avatar(imageUrl: ""),
              8.kW,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "California Agency",
                        style: CustomFonts.labelMedium,
                      ),
                      4.kW,
                      HeroIcon(
                        HeroIcons.checkBadge,
                        size: 20.0,
                        style: HeroIconStyle.solid,
                      ),
                    ],
                  ),
                  Text(
                    "California, USA",
                    style: CustomFonts.bodySmall.copyWith(
                      color: CustomColors.textGrey,
                    ),
                  )
                ],
              )
            ],
          ),

          20.kH,
          // Beneficiary
          Row(
            children: [
              Icon(
                Symbols.diversity_1_rounded,
                weight: 600,
              ),
              6.kW,
              Text(
                "Beneficiary",
                style: CustomFonts.titleMedium,
              ),
            ],
          ),
          12.kH,
          Row(
            children: [
              Avatar(imageUrl: ""),
              8.kW,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Emily",
                    style: CustomFonts.labelMedium,
                  ),
                  Text(
                    "California, USA",
                    style: CustomFonts.bodySmall.copyWith(
                      color: CustomColors.textGrey,
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
