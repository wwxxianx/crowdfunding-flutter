import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/campaign_category_toggle_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';

class CampaignsFilterBottomSheet extends StatelessWidget {
  const CampaignsFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Category",
            style: CustomFonts.labelMedium,
          ),
          12.kH,
          // CamapaignCategoryList(onPressed: (campaignCategory) {}),
          20.kH,
          //Divider
          Container(
            height: 1,
            decoration: BoxDecoration(
              color: CustomColors.divider,
            ),
          ),
          20.kH,
          Text(
            "Location",
            style: CustomFonts.labelMedium,
          ),
          12.kH,
          ...List.generate(20, (index) {
            return CheckboxListTile(
              value: false,
              onChanged: (value) {},
              title: Text(
                "Kuala Lumpur",
                style: CustomFonts.labelMedium,
              ),
              contentPadding: EdgeInsets.all(0),
            );
          }),
        ],
      ),
    );
  }
}
