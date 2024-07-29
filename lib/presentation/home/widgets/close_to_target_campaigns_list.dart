import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign/campaign_card.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/campaign_details_screen.dart';
import 'package:crowdfunding_flutter/state_management/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CloseToTargetCampaignsList extends StatelessWidget {
  const CloseToTargetCampaignsList({super.key});
  @override
  Widget build(BuildContext context) {
    final closeToTargetCampaignsResult = context
        .select((HomeBloc bloc) => bloc.state.closeToTargetCampaignsResult);
    if (closeToTargetCampaignsResult is ApiResultSuccess<List<Campaign>> &&
        closeToTargetCampaignsResult.data.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding),
            child: Text(
              "Close to target!",
              style: CustomFonts.titleLarge,
            ),
          ),
          12.kH,
          SizedBox(
            height: closeToTargetCampaignsResult.data.any(
                    (element) => element.firstMatchedCommunityChallenge != null)
                ? 490
                : 400,
            child: ListView.builder(
              padding: const EdgeInsets.only(
                  left: Dimensions.screenHorizontalPadding),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: closeToTargetCampaignsResult.data.length,
              itemBuilder: (context, index) {
                final campaign = closeToTargetCampaignsResult.data[index];
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: CampaignCard(
                    height: 550,
                    campaign: campaign,
                    onPressed: () {
                      context.push(CampaignDetailsScreen.generateRoute(
                          campaignId: campaign.id));
                    },
                    showMatchChallengeBar: true,
                  ),
                );
              },
            ),
          )
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
