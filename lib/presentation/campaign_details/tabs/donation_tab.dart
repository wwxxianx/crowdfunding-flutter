import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/string.dart';
import 'package:crowdfunding_flutter/common/widgets/avatar/avatar.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/common/widgets/skeleton.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_donation.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_bloc.dart';
import 'package:crowdfunding_flutter/state_management/campaign_details/campaign_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

class DonationTab extends StatelessWidget {
  const DonationTab({super.key});

  Widget _buildDonationContent(CampaignDetailsState state) {
    final campaignResult = state.campaignResult;
    if (campaignResult is ApiResultSuccess<Campaign>) {
      if (campaignResult.data.donations.isEmpty) {
        return Text("Empty");
      }
      return Column(
        children: [
        // Recent donation
          Row(
            children: [
              const Icon(
                Symbols.nest_clock_farsight_analog_rounded,
              ),
              4.kW,
              const Text(
                "Recent donations",
                style: CustomFonts.labelLarge,
              ),
            ],
          ),
          6.kH,
          _buildDonationList(campaignResult.data.recentThreeDonations),
          20.kH,
          Row(
            children: [
              const Icon(
                Symbols.trophy_rounded,
              ),
              4.kW,
              const Text(
                "Top donations",
                style: CustomFonts.labelLarge,
              ),
            ],
          ),
          6.kH,
          _buildDonationList(campaignResult.data.topThreeDonations),
        ],
      );
    }
    if (campaignResult is ApiResultFailure) {
      return Text("Something went wrong");
    }
    // Loading
    return Skeleton();
  }

  Widget _buildDonationList(List<CampaignDonation> donations) {
    return Column(
      children: donations.map((donation) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: DonationItem(donation: donation),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignDetailsBloc, CampaignDetailsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.screenHorizontalPadding,
            vertical: 16.0,
          ),
          child: Column(
            children: [
              _buildDonationContent(state),
            ],
          ),
        );
      },
    );
  }
}

class DonationItem extends StatelessWidget {
  final CampaignDonation donation;
  const DonationItem({
    super.key,
    required this.donation,
  });

  @override
  Widget build(BuildContext context) {
    final displayName =
        donation.isAnonymous ? "Anonymous" : donation.user.fullName;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Avatar(
          imageUrl: donation.user.profileImageUrl,
          placeholder: donation.user.fullName[0],
        ),
        16.kW,
        Column(
          children: [
            Text(
              displayName,
              style: CustomFonts.labelMedium,
            ),
            Text(
              donation.createdAt.toTimeAgo(),
              style:
                  CustomFonts.labelSmall.copyWith(color: CustomColors.textGrey),
            ),
          ],
        ),
        const Spacer(),
        Text(
          "RM ${donation.amount}",
          style: CustomFonts.labelLarge,
        ),
      ],
    );
  }
}
