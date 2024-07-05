import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign/campaign_card.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/state_management/home/home_bloc.dart';
import 'package:crowdfunding_flutter/state_management/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuccessfulCampaignsShowcase extends StatelessWidget {
  const SuccessfulCampaignsShowcase({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final completedCampaignsResult = state.completedCampaignsResult;
        if (completedCampaignsResult is ApiResultSuccess<List<Campaign>>) {
          return SizedBox(
            height: 400,
            child: ListView.builder(
              padding: const EdgeInsets.only(
                left: Dimensions.screenHorizontalPadding,
              ),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: completedCampaignsResult.data.length,
              itemBuilder: (context, index) {
                final campaign = completedCampaignsResult.data[index];
                return CampaignCard(
                  height: 550,
                  campaign: campaign,
                  onPressed: () {
                    // context.push(CampaignDetailsScreen.generateRoute(
                    //     campaignId: campaign.id));
                  },
                );
              },
            ),
          );
        }
        if (completedCampaignsResult is ApiResultLoading) {
          return const Text("Loading...");
        }
        if (completedCampaignsResult is ApiResultFailure) {
          return const Text("Error...");
        }
        return const SizedBox();
      },
    );
  }
}
