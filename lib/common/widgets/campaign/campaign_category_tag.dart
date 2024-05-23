import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/string.dart';
import 'package:crowdfunding_flutter/common/widgets/button/campaign_category_toggle_button.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_category.dart';
import 'package:flutter/material.dart';

class CampaignCategoryTag extends StatelessWidget {
  final bool isSmall;
  final CampaignCategory category;
  const CampaignCategoryTag({
    super.key,
    this.isSmall = false,
    required this.category,
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
          color: CampaignCategoryEnum.values
              .byName(category.title)
              .getCampaignBGColor(),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CampaignCategoryEnum.values
                .byName(category.title)
                .getCampaignIcon(),
            4.kW,
            Text(
              category.title.capitalize(),
              style: textStyle.copyWith(
                color: CampaignCategoryEnum.values
                    .byName(category.title)
                    .getCampaignTextColor(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
