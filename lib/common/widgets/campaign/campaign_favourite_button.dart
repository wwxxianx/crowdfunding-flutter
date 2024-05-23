import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_icon_button.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/user/user_favourite_campaign.dart';
import 'package:crowdfunding_flutter/state_management/user/favourite_campaign/favourite_campaign_bloc.dart';
import 'package:crowdfunding_flutter/state_management/user/favourite_campaign/favourite_campaign_event.dart';
import 'package:crowdfunding_flutter/state_management/user/favourite_campaign/favourite_campaign_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heroicons/heroicons.dart';

class CampaignFavouriteButton extends StatelessWidget {
  final Campaign campaign;
  final VoidCallback onPressed;
  const CampaignFavouriteButton({
    super.key,
    required this.campaign,
    required this.onPressed,
  });

  void _handleFavouriteButtonPressed(BuildContext context) {
    final favouriteCampaignsResult =
        context.read<FavouriteCampaignBloc>().state.favouriteCampaignsResult;
    if (favouriteCampaignsResult
        is ApiResultSuccess<List<UserFavouriteCampaign>>) {
      if (favouriteCampaignsResult.data.any((favouriteCampaign) =>
          favouriteCampaign.campaign.id == campaign.id)) {
        // Remove from favourite
        context
            .read<FavouriteCampaignBloc>()
            .add(OnDeleteCampaignFromFavourite(campaign.id));
      } else {
        // Add to favourite
        context
            .read<FavouriteCampaignBloc>()
            .add(OnAddCampaignToFavourite(campaign.id));
      }
    }
  }

  Widget _buildIcon(
      ApiResult<List<UserFavouriteCampaign>> favouriteCampaignsResult) {
    if (favouriteCampaignsResult is ApiResultLoading ||
        favouriteCampaignsResult is ApiResultInitial ||
        favouriteCampaignsResult is ApiResultFailure) {
      return const SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: CustomColors.accentGreen,
        ),
      );
    }
    if (favouriteCampaignsResult
        is ApiResultSuccess<List<UserFavouriteCampaign>>) {
      if (favouriteCampaignsResult.data.any((favouriteCampaign) =>
          favouriteCampaign.campaign.id == campaign.id)) {
        return SvgPicture.asset(
          "assets/icons/heart-filled-border.svg",
        );
      } else {
        return const HeroIcon(
          HeroIcons.heart,
        );
      }
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCampaignBloc, FavouriteCampaignState>(
      builder: (context, state) {
        return CustomIconButton(
          isLoading: state.favouriteCampaignsResult is ApiResultLoading ||
              (state.campaignIdToEdit != null &&
                  state.campaignIdToEdit == campaign.id),
          onPressed: () {
            _handleFavouriteButtonPressed(context);
          },
          icon: _buildIcon(state.favouriteCampaignsResult),
        );
      },
    );
  }
}
