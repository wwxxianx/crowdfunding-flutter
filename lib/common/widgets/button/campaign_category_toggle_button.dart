import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class CampaignCategoryToggleButton extends StatefulWidget {
  const CampaignCategoryToggleButton({super.key});

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
              color: Color(0xFFFFF1F2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Symbols.ecg_heart,
                  size: 20.0,
                  color: Color(0xFF9F1239),
                ),
                4.kW,
                Text(
                  "Medical",
                  style: CustomFonts.labelMedium.copyWith(
                    color: Color(0xFF9F1239),
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
