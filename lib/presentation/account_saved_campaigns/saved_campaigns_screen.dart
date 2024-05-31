import 'package:crowdfunding_flutter/common/theme/dimension.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign/campaign_card.dart';
import 'package:crowdfunding_flutter/common/widgets/campaign/campaign_loading_card.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/domain/model/user/user_favourite_campaign.dart';
import 'package:crowdfunding_flutter/state_management/user/favourite_campaign/favourite_campaign_bloc.dart';
import 'package:crowdfunding_flutter/state_management/user/favourite_campaign/favourite_campaign_event.dart';
import 'package:crowdfunding_flutter/state_management/user/favourite_campaign/favourite_campaign_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SavedCampaignsScreen extends StatelessWidget {
  static const String route = "/saved-campaigns";
  const SavedCampaignsScreen({super.key});

  Widget _buildContent(FavouriteCampaignState state) {
    final favouriteCampaignsResult = state.favouriteCampaignsResult;
    if (favouriteCampaignsResult
        is ApiResultSuccess<List<UserFavouriteCampaign>>) {
      if (favouriteCampaignsResult.data.isEmpty) {
        return Text("Empty");
      }
      return ListView.builder(
        shrinkWrap: true,
        itemCount: favouriteCampaignsResult.data.length,
        itemBuilder: (context, index) {
          return CampaignCard(
            campaign: favouriteCampaignsResult.data[index].campaign,
          );
        },
      );
    }
    if (favouriteCampaignsResult is ApiResultFailure) {
      return Text("Something went wrong");
    }
    // Loading and initial
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) => const CampaignLoadingCard(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return FavouriteCampaignBloc(
          createFavouriteCampaign: serviceLocator(),
          getFavouriteCampaigns: serviceLocator(),
          deleteFavouriteCampaign: serviceLocator(),
        )..add(OnFetchFavouriteCampaigns());
      },
      child: BlocBuilder<FavouriteCampaignBloc, FavouriteCampaignState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  SvgPicture.asset("assets/icons/hearts.svg"),
                  4.kW,
                  Text(
                    "Saved Campaigns",
                    style: CustomFonts.labelMedium,
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.screenHorizontalPadding,
                  ),
                  child: _buildContent(state),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
