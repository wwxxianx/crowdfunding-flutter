// ignore_for_file: constant_identifier_names

import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/container/chip.dart';
import 'package:flutter/material.dart';

enum FundraiserIdentificationStatusEnum {
  PENDING,
  UNDER_REVIEW,
  VERIFIED,
  REJECTED;

  @override
  String toString() {
    switch (this) {
      case FundraiserIdentificationStatusEnum.PENDING:
        return 'Pending';
      case FundraiserIdentificationStatusEnum.UNDER_REVIEW:
        return 'Under Review';
      case FundraiserIdentificationStatusEnum.VERIFIED:
        return 'Verified';
      case FundraiserIdentificationStatusEnum.REJECTED:
        return 'Rejected';
    }
  }
}

enum CampaignPublishStatusEnum {
  PENDING,
  PUBLISHED,
  SUSPENDED;

  @override
  String toString() {
    switch (this) {
      case CampaignPublishStatusEnum.PENDING:
        return 'Pending';
      case CampaignPublishStatusEnum.PUBLISHED:
        return 'Published';
      case CampaignPublishStatusEnum.SUSPENDED:
        return 'Suspended';
    }
  }
}

extension CampaignPublishStatusExtension on CampaignPublishStatusEnum {
  CustomChipStyle get chipStyle {
    switch (this) {
      case CampaignPublishStatusEnum.PENDING:
        return CustomChipStyle.slate;
      case CampaignPublishStatusEnum.PUBLISHED:
        return CustomChipStyle.green;
      case CampaignPublishStatusEnum.SUSPENDED:
        return CustomChipStyle.red;
    }
  }

  String get displayTitle {
    switch (this) {
      case CampaignPublishStatusEnum.PENDING:
        return 'Your campaign is not ready to collect fund. Please complete your identity verification and setup you bank account.';
      case CampaignPublishStatusEnum.PUBLISHED:
        return 'Your campaign can now collect funds from our community';
      case CampaignPublishStatusEnum.SUSPENDED:
        return 'This campaign is suspended';
    }
  }

  Color get titleColor {
    switch (this) {
      case CampaignPublishStatusEnum.PENDING:
        return CustomColors.slate700;
      case CampaignPublishStatusEnum.PUBLISHED:
        return CustomColors.green700;
      case CampaignPublishStatusEnum.SUSPENDED:
        return CustomColors.red700;
    }
  }

  Color get borderColor {
    switch (this) {
      case CampaignPublishStatusEnum.PENDING:
        return CustomColors.slate400;
      case CampaignPublishStatusEnum.PUBLISHED:
        return CustomColors.green400;
      case CampaignPublishStatusEnum.SUSPENDED:
        return CustomColors.red400;
    }
  }

  Widget buildStatusWidget() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomChip(
            style: chipStyle,
            child: Text(toString()),
          ),
          4.kH,
          Text(
            displayTitle,
            style: CustomFonts.bodySmall.copyWith(color: titleColor),
          ),
        ],
      ),
    );
  }
}
