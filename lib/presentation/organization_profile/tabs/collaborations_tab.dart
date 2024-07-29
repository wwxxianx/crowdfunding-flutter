import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign/campaign_card.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/collaboration/collaboration.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/manage_campaign_details_screen.dart';
import 'package:crowdfunding_flutter/state_management/organization_profile/organization_profile_bloc.dart';
import 'package:crowdfunding_flutter/state_management/organization_profile/organization_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CollaborationsTabContent extends StatelessWidget {
  const CollaborationsTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrganizationProfileBloc, OrganizationProfileState>(
      builder: (context, state) {
        final collaborationsResult = state.collaborationsResult;
        if (collaborationsResult is ApiResultSuccess<List<Collaboration>>) {
          return ListView.builder(
            padding: const EdgeInsets.all(Dimensions.screenHorizontalPadding),
            shrinkWrap: true,
            itemCount: collaborationsResult.data.length,
            itemBuilder: (context, index) {
              final campaign = collaborationsResult.data[index].campaign;
              return CampaignCard(
                campaign: campaign,
                onPressed: () {
                  context.push(ManageCampaignDetailsScreen.generateRoute(
                      campaignId: campaign.id));
                },
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
