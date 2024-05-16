import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/fetch_campaign.dart';
import 'package:crowdfunding_flutter/state_management/home/home_event.dart';
import 'package:crowdfunding_flutter/state_management/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchCampaign _fetchCampaign;
  HomeBloc({
    required FetchCampaign fetchCampaign,
  })  : _fetchCampaign = fetchCampaign,
        super(HomeInitial()) {
    on<HomeEvent>((event, emit) => emit(HomeInitial()));
    on<FetchRecommendedCampaigns>(_fetchRecommendedCampaigns);
  }

  void _fetchRecommendedCampaigns(
    FetchRecommendedCampaigns event,
    Emitter<HomeState> emit,
  ) async {
    emit(FetchRecommendedCampaignsLoading());
    final res = await _fetchCampaign.call(NoPayload());
    res.fold(
      (l) => emit(FetchRecommendedCampaignsError(message: l.message)),
      (r) => emit(FetchRecommendedCampaignsSuccess(campaigns: r)),
    );
  }
}
