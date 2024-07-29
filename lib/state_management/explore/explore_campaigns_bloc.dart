import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/enum/campaign_enum.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/fetch_campaigns.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_event.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreCampaignsBloc
    extends Bloc<ExploreCampaignsEvent, ExploreCampaignsState> {
  final FetchCampaigns _fetchCampaigns;
  ExploreCampaignsBloc({
    required FetchCampaigns fetchCampaigns,
  })  : _fetchCampaigns = fetchCampaigns,
        super(const ExploreCampaignsState.initial()) {
    on<ExploreCampaignsEvent>(_onEvent);
  }

  Future<void> _onEvent(
    ExploreCampaignsEvent event,
    Emitter<ExploreCampaignsState> emit,
  ) async {
    return switch (event) {
      final OnFetchCampaigns e => _onFetchCampaigns(e, emit),
      final OnViewChange e => _onViewChange(e, emit),
      final OnSelectCampaignCategory e => _onSelectCampaignCategory(e, emit),
      final OnSelectStateAndRegion e => _onSelectStateAndRegion(e, emit),
      final OnSearchQueryChanged e => _onSearchQueryChanged(e, emit),
      final OnRefreshCampaigns e => _onRefreshCampaigns(e, emit),
    };
  }

  Future<void> _onRefreshCampaigns(
    OnRefreshCampaigns event,
    Emitter<ExploreCampaignsState> emit,
  ) async {
    final payload = FetchCampaignsPayload(
      categoryIds: state.selectedCategoryIds,
      stateIds: state.selectedStateIds,
      searchQuery: state.searchQuery,
      isPublished: true,
      identificationStatus: IdentificationStatusEnum.VERIFIED,
    );
    final res = await _fetchCampaigns(payload);
    res.fold(
      (failure) => emit(state.copyWith(
          campaignsResult: ApiResultFailure(failure.errorMessage))),
      (campaigns) =>
          emit(state.copyWith(campaignsResult: ApiResultSuccess(campaigns))),
    );
  }

  void _onSearchQueryChanged(
    OnSearchQueryChanged event,
    Emitter<ExploreCampaignsState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.searchQuery));
  }

  void _onSelectStateAndRegion(
    OnSelectStateAndRegion event,
    Emitter<ExploreCampaignsState> emit,
  ) {
    if (state.selectedStateIds.contains(event.stateId)) {
      final updatedStateIds =
          state.selectedStateIds.where((id) => id != event.stateId).toList();
      emit(
        state.copyWith(
          selectedStateIds: updatedStateIds,
        ),
      );
    } else {
      final updatedStateIds = [...state.selectedStateIds, event.stateId];
      emit(
        state.copyWith(
          selectedStateIds: updatedStateIds,
        ),
      );
    }
  }

  void _onSelectCampaignCategory(
    OnSelectCampaignCategory event,
    Emitter<ExploreCampaignsState> emit,
  ) {
    if (state.selectedCategoryIds.contains(event.categoryId)) {
      final updatedCategoryIds = state.selectedCategoryIds
          .where((id) => id != event.categoryId)
          .toList();
      emit(
        state.copyWith(
          selectedCategoryIds: updatedCategoryIds,
        ),
      );
    } else {
      final updatedCategoryIds = [
        ...state.selectedCategoryIds,
        event.categoryId
      ];
      emit(
        state.copyWith(
          selectedCategoryIds: updatedCategoryIds,
        ),
      );
    }
  }

  Future<void> _onFetchCampaigns(
    OnFetchCampaigns event,
    Emitter<ExploreCampaignsState> emit,
  ) async {
    emit(state.copyWith(campaignsResult: const ApiResultLoading()));
    final payload = FetchCampaignsPayload(
      categoryIds: state.selectedCategoryIds,
      stateIds: state.selectedStateIds,
      searchQuery: state.searchQuery,
      isPublished: true,
      identificationStatus: IdentificationStatusEnum.VERIFIED,
    );
    final res = await _fetchCampaigns(payload);
    res.fold(
      (failure) => emit(state.copyWith(
          campaignsResult: ApiResultFailure(failure.errorMessage))),
      (campaigns) =>
          emit(state.copyWith(campaignsResult: ApiResultSuccess(campaigns))),
    );
  }

  void _onViewChange(
    OnViewChange event,
    Emitter<ExploreCampaignsState> emit,
  ) {
    if (event.isGridView && state.isGridView ||
        !event.isGridView && !state.isGridView) {
      return;
    }
    if (event.isGridView) {
      emit(state.copyWith(isGridView: true));
    } else {
      emit(state.copyWith(isGridView: false));
    }
  }
}
