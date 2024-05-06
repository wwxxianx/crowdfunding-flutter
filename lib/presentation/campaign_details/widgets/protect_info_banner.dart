import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ProtectInfoBanner extends StatelessWidget {
  const ProtectInfoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: CustomColors.lightBlue,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Symbols.add_moderator,
                size: 20.0,
                color: CustomColors.accentBlue,
              ),
              4.kW,
              Text(
                "Protected Fundraiser",
                style: CustomFonts.labelMedium.copyWith(
                  fontSize: 14.0,
                  color: CustomColors.accentBlue,
                ),
              )
            ],
          ),
          2.kH,
          Text(
            "We guarantee a full refund of your donation in case of fraud.",
            style: TextStyle(
              fontSize: 14.0,
              color: CustomColors.accentBlue,
            ),
          ),
        ],
      ),
    );
  }
}
