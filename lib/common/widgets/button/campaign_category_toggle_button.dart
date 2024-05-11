import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/string.dart';
import 'package:crowdfunding_flutter/presentation/explore/explore_screen.dart';
import 'package:flutter/material.dart';

class CamapaignCategoryList extends StatelessWidget {
  final void Function(CampaignCategory campaignCategory) onPressed;
  final campaignCategories = [
    CampaignCategory.medical,
    CampaignCategory.education,
    CampaignCategory.animal,
    CampaignCategory.food,
    CampaignCategory.baby,
    CampaignCategory.emergency,
    CampaignCategory.environment,
    CampaignCategory.naturalDisaster,
  ];

  CamapaignCategoryList({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      direction: Axis.horizontal,
      children: [
        ...campaignCategories.map(
          (category) => CampaignCategoryToggleButton(
            campaignCategory: category,
            onPressed: (campaignCategory) {
              onPressed(campaignCategory);
            },
          ),
        )
      ],
    );
  }
}

class CampaignCategoryToggleButton extends StatefulWidget {
  final CampaignCategory campaignCategory;
  final void Function(CampaignCategory campaignCategory) onPressed;
  const CampaignCategoryToggleButton({
    super.key,
    required this.campaignCategory,
    required this.onPressed,
  });

  @override
  State<CampaignCategoryToggleButton> createState() =>
      _CampaignCategoryToggleButtonState();
}

class _CampaignCategoryToggleButtonState
    extends State<CampaignCategoryToggleButton> {
  bool isSelected = false;

  void _handleToggle() {
    setState(() {
      isSelected = !isSelected;
    });
    widget.onPressed(widget.campaignCategory);
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: InkWell(
        onTap: _handleToggle,
        child: Opacity(
          opacity: isSelected ? 1 : 0.6,
          child: Container(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 12.0,
              top: 8,
              bottom: 8,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.black : Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(100.0),
              color: widget.campaignCategory.getCampaignBGColor(),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.campaignCategory.getCampaignIcon(),
                4.kW,
                Text(
                  widget.campaignCategory.name.capitalize(),
                  style: CustomFonts.labelMedium.copyWith(
                    color: widget.campaignCategory.getCampaignTextColor(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
