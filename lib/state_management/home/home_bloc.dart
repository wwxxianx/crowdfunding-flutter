import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/fetch_campaigns.dart';
import 'package:crowdfunding_flutter/state_management/home/home_event.dart';
import 'package:crowdfunding_flutter/state_management/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchCampaigns _fetchCampaign;
  HomeBloc({
    required FetchCampaigns fetchCampaign,
  })  : _fetchCampaign = fetchCampaign,
        super(const HomeState.initial()) {
    on<HomeEvent>(_onEvent);
  }

  Future<void> _onEvent(
    HomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    return switch (event) {
      final OnFetchRecommendedCampaigns e =>
        _onFetchRecommendedCampaigns(e, emit),
    };
  }

  Future<void> _onFetchRecommendedCampaigns(
    OnFetchRecommendedCampaigns event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(recommendedCampaignsResult: const ApiResultLoading()));
    final res =
        await _fetchCampaign.call(const FetchCampaignsPayload(userId: null));
    res.fold(
      (l) => emit(state.copyWith(recommendedCampaignsResult: ApiResultFailure(l.errorMessage))),
      (r) => emit(state.copyWith(recommendedCampaignsResult: ApiResultSuccess(r))),
    );
  }
}
