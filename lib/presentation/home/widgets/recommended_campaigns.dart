import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign/campaign_card.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign/campaign_loading_card.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/state_management/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RecommendedCampaigns extends StatelessWidget {
  const RecommendedCampaigns({super.key});

  @override
  Widget build(BuildContext context) {
    final recommendedCampaignsResult = context
        .select((HomeBloc bloc) => bloc.state.recommendedCampaignsResult);

    if (recommendedCampaignsResult is ApiResultSuccess<List<Campaign>>) {
      return SizedBox(
        height: 550,
        child: ListView.builder(
          padding: const EdgeInsets.only(
            left: Dimensions.screenHorizontalPadding,
          ),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: recommendedCampaignsResult.data.length,
          itemBuilder: (context, index) {
            final campaign = recommendedCampaignsResult.data[index];
            return Row(
              children: [
                CampaignCard(
                  height: 550,
                  campaign: campaign,
                  onPressed: () {
                    // Navigator.push(
                    //     context, CampaignDetailsScreen.route());
                    context.push('/campaign-details/${campaign.id}');
                  },
                ),
                12.kW,
              ],
            );
          },
        ),
      );
    }
    if (recommendedCampaignsResult is ApiResultFailure) {
      return const Text("Something went wrong");
    }
    // Loading and initial
    return SizedBox(
      height: 500,
      child: ListView.builder(
        padding: const EdgeInsets.only(
          left: Dimensions.screenHorizontalPadding,
        ),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Row(
            children: [
              const CampaignLoadingCard(
                height: 500,
              ),
              12.kW,
            ],
          );
        },
      ),
    );
  }
}
