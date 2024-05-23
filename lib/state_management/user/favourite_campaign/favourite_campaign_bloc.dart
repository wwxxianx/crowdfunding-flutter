import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/favourite_campaign/favourite_campaign_payload.dart';
import 'package:crowdfunding_flutter/domain/model/user/user_favourite_campaign.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/favourite_campaign/create_favourite_campaign.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/favourite_campaign/delete_favourite_campaign.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/favourite_campaign/fetch_favourite_campaigns.dart';
import 'package:crowdfunding_flutter/state_management/user/favourite_campaign/favourite_campaign_event.dart';
import 'package:crowdfunding_flutter/state_management/user/favourite_campaign/favourite_campaign_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteCampaignBloc
    extends Bloc<FavouriteCampaignEvent, FavouriteCampaignState> {
  final CreateFavouriteCampaign _createFavouriteCampaign;
  final FetchFavouriteCampaigns _getFavouriteCampaigns;
  final DeleteFavouriteCampaign _deleteFavouriteCampaign;

  FavouriteCampaignBloc({
    required CreateFavouriteCampaign createFavouriteCampaign,
    required FetchFavouriteCampaigns getFavouriteCampaigns,
    required DeleteFavouriteCampaign deleteFavouriteCampaign,
  })  : _createFavouriteCampaign = createFavouriteCampaign,
        _getFavouriteCampaigns = getFavouriteCampaigns,
        _deleteFavouriteCampaign = deleteFavouriteCampaign,
        super(const FavouriteCampaignState.initial()) {
    on<FavouriteCampaignEvent>(_onEvent);
  }

  Future<void> _onEvent(
    FavouriteCampaignEvent event,
    Emitter<FavouriteCampaignState> emit,
  ) async {
    return switch (event) {
      final OnAddCampaignToFavourite e => _onAddCampaignToFavourite(e, emit),
      final OnFetchFavouriteCampaigns e => _onFetchFavouriteCampaigns(e, emit),
      final OnDeleteCampaignFromFavourite e =>
        _onDeleteCampaignFromFavourite(e, emit),
    };
  }

  Future<void> _onDeleteCampaignFromFavourite(
    OnDeleteCampaignFromFavourite event,
    Emitter emit,
  ) async {
    emit(state.copyWith(campaignIdToEdit: event.campaignId));
    final payload = FavouriteCampaignPayload(campaignId: event.campaignId);
    final res = await _deleteFavouriteCampaign(payload);
    res.fold(
      (failure) => null,
      (unit) {
        final favouriteCampaignsResult = state.favouriteCampaignsResult;
        if (favouriteCampaignsResult is ApiResultSuccess<List<UserFavouriteCampaign>>) {
          List<UserFavouriteCampaign> updatedFavouriteCampaigns = favouriteCampaignsResult
              .data
              .where((favourite) => favourite.campaign.id != event.campaignId)
              .toList();
          emit(state.copyWith(
            favouriteCampaignsResult:
                ApiResultSuccess(updatedFavouriteCampaigns),
            campaignIdToEdit: null,
          ));
        }
      },
    );
  }

  Future<void> _onFetchFavouriteCampaigns(
    OnFetchFavouriteCampaigns event,
    Emitter emit,
  ) async {
    emit(const FavouriteCampaignState.fetchFavouriteCampaignsInProgress());
    final res = await _getFavouriteCampaigns.call(NoPayload());
    res.fold(
      (failure) => emit(FavouriteCampaignState.fetchFavouriteCampaignsFailure(
          failure.errorMessage)),
      (campaigns) => emit(
          FavouriteCampaignState.fetchFavouriteCampaignsSuccess(campaigns)),
    );
  }

  Future<void> _onAddCampaignToFavourite(
    OnAddCampaignToFavourite event,
    Emitter emit,
  ) async {
    emit(state.copyWith(campaignIdToEdit: event.campaignId));
    final payload = FavouriteCampaignPayload(campaignId: event.campaignId);
    final res = await _createFavouriteCampaign(payload);
    res.fold(
      (failure) => null,
      (favouriteCampaign) {
        List<UserFavouriteCampaign> updatedFavouriteCampaigns = [favouriteCampaign];
        final favouriteCampaignsResult = state.favouriteCampaignsResult;
        if (favouriteCampaignsResult is ApiResultSuccess<List<UserFavouriteCampaign>> &&
            favouriteCampaignsResult.data.isNotEmpty) {
          updatedFavouriteCampaigns = [
            favouriteCampaign,
            ...favouriteCampaignsResult.data
          ];
        }
        emit(
          state.copyWith(
              campaignIdToEdit: null,
              favouriteCampaignsResult:
                  ApiResultSuccess(updatedFavouriteCampaigns)),
        );
      },
    );
  }
}
