import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/container/chip.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/enum/campaign_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FundraiserIdentificationCard extends StatelessWidget {
  final VoidCallback? onPressed;
  final IdentificationStatusEnum? status;
  const FundraiserIdentificationCard({
    super.key,
    this.status,
    this.onPressed,
  });

  CustomChipStyle get chipStyle {
    switch (status) {
      case IdentificationStatusEnum.UNDER_REVIEW:
        return CustomChipStyle.amber;
      case IdentificationStatusEnum.VERIFIED:
        return CustomChipStyle.green;
      case IdentificationStatusEnum.REJECTED:
        return CustomChipStyle.red;
      default:
        return CustomChipStyle.slate;
    }
  }

  String get actionText {
    switch (status) {
      case IdentificationStatusEnum.PENDING:
        return 'Complete my identity';
      default:
        return 'Check my identity';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: CustomColors.containerBorderSlate),
        boxShadow: CustomColors.containerSlateShadow,
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/icons/identification.svg'),
              4.kW,
              const Text(
                'Verify your identity',
                style: CustomFonts.labelMedium,
              ),
              const Spacer(),
              if (status != null)
                CustomChip(
                  style: chipStyle,
                  child: Text(status.toString()),
                ),
            ],
          ),
          6.kH,
          const Text(
            'For legal compliance, every fundraiser have to identify for fundraising campaigns.',
            style: CustomFonts.bodySmall,
          ),
          6.kH,
          SizedBox(
            width: double.maxFinite,
            child: CustomButton(
              height: 38,
              borderRadius: BorderRadius.circular(4),
              style: CustomButtonStyle.white,
              onPressed: onPressed,
              child: Text(
                actionText,
                style: CustomFonts.labelSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
