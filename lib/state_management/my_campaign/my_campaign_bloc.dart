import 'package:crowdfunding_flutter/domain/usecases/campaign/fetch_campaigns.dart';
import 'package:crowdfunding_flutter/state_management/my_campaign/my_campaign_event.dart';
import 'package:crowdfunding_flutter/state_management/my_campaign/my_campaign_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCampaignBloc extends Bloc<MyCampaignEvent, MyCampaignState> {
  final FetchCampaigns _fetchCampaigns;

  MyCampaignBloc({
    required FetchCampaigns fetchCampaigns,
  })  : _fetchCampaigns = fetchCampaigns,
        super(const MyCampaignState.initial()) {
    on<MyCampaignEvent>(_onEvent);
  }

  Future<void> _onEvent(
    MyCampaignEvent event,
    Emitter<MyCampaignState> emit,
  ) async {
    return switch (event) {
      final OnFetchMyCampaign e => _onFetchMyCampaign(e, emit),
    };
  }

  Future<void> _onFetchMyCampaign(
    OnFetchMyCampaign event,
    Emitter emit,
  ) async {
    emit(const MyCampaignState.fetchMyCampaignsInProgress());
    final payload = FetchCampaignsPayload(userId: event.userId);
    final res = await _fetchCampaigns(payload);
    res.fold(
      (failure) {
        emit(MyCampaignState.fetchMyCampaignFailure(failure.errorMessage));
      },
      (campaigns) {
        emit(MyCampaignState.fetchMyCampaignsSuccess(data: campaigns));
      },
    );
  }
}
