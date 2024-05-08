import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class CampaignCategoryTag extends StatelessWidget {
  final bool isSmall;
  const CampaignCategoryTag({
    super.key,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle =
        isSmall ? CustomFonts.labelExtraSmall : CustomFonts.labelMedium;

    return IntrinsicWidth(
      child: Container(
        padding: EdgeInsets.only(
          left: isSmall ? 8.0 : 10.0,
          right: isSmall ? 10.0 : 12.0,
          top: isSmall ? 6.0 : 8,
          bottom: isSmall ? 6.0 : 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color(0xFFFFF1F2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Symbols.ecg_heart,
              size: isSmall ? 16.0 : 20.0,
              color: Color(0xFF9F1239),
            ),
            4.kW,
            Text(
              "Medical",
              style: textStyle.copyWith(
                color: Color(0xFF9F1239),
              ),
            )
          ],
        ),
      ),
    );
  }
}