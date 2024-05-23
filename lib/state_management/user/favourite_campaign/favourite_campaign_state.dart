import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/user/user_favourite_campaign.dart';
import 'package:equatable/equatable.dart';

final class FavouriteCampaignState extends Equatable {
  final ApiResult<List<UserFavouriteCampaign>> favouriteCampaignsResult;
  final String? campaignIdToEdit;

  const FavouriteCampaignState._({
    required this.favouriteCampaignsResult,
    this.campaignIdToEdit,
  });

  const FavouriteCampaignState.initial()
      : this._(favouriteCampaignsResult: const ApiResultInitial());

  const FavouriteCampaignState.fetchFavouriteCampaignsInProgress()
      : this._(favouriteCampaignsResult: const ApiResultLoading());

  FavouriteCampaignState.fetchFavouriteCampaignsSuccess(
      List<UserFavouriteCampaign> campaigns)
      : this._(favouriteCampaignsResult: ApiResultSuccess(campaigns));

  FavouriteCampaignState.fetchFavouriteCampaignsFailure(String? errorMessage)
      : this._(favouriteCampaignsResult: ApiResultFailure(errorMessage));

  FavouriteCampaignState copyWith({
    ApiResult<List<UserFavouriteCampaign>>? favouriteCampaignsResult,
    String? campaignIdToEdit,
  }) {
    return FavouriteCampaignState._(
      favouriteCampaignsResult:
          favouriteCampaignsResult ?? this.favouriteCampaignsResult,
      campaignIdToEdit: campaignIdToEdit,
    );
  }

  @override
  List<Object?> get props => [
        favouriteCampaignsResult,
        campaignIdToEdit,
      ];
}
