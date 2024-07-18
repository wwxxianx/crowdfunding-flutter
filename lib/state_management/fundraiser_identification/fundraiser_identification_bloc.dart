import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/update_campaign_fundraiser_payload.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/fetch_campaign_fundraiser.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/update_campaign_fundraiser.dart';
import 'package:crowdfunding_flutter/state_management/fundraiser_identification/fundraiser_identification_event.dart';
import 'package:crowdfunding_flutter/state_management/fundraiser_identification/fundraiser_identification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FundraiserIdentificationBloc
    extends Bloc<FundraiserIdentificationEvent, FundraiserIdentificationState> {
  final FetchCampaignFundraiser _fetchCampaignFundraiser;
  final UpdateCampaignFundraiser _updateCampaignFundraiser;
  FundraiserIdentificationBloc({
    required FetchCampaignFundraiser fetchCampaignFundraiser,
    required UpdateCampaignFundraiser updateCampaignFundraiser,
  })  : _fetchCampaignFundraiser = fetchCampaignFundraiser,
        _updateCampaignFundraiser = updateCampaignFundraiser,
        super(const FundraiserIdentificationState.initial()) {
    on<FundraiserIdentificationEvent>(_onEvent);
  }

  Future<void> _onEvent(
    FundraiserIdentificationEvent event,
    Emitter<FundraiserIdentificationState> emit,
  ) async {
    return switch (event) {
      final OnFetchCampaignFundraiser e => _onFetchCampaignFundraiser(e, emit),
      final OnIdNumberChanged e => _onIdNumberChanged(e, emit),
      final OnSignatureFileChanged e => _onSignatureFileChanged(e, emit),
      final OnUpdateFundraiser e => _onUpdateFundraiser(e, emit),
    };
  }

  Future<void> _onUpdateFundraiser(
    OnUpdateFundraiser event,
    Emitter<FundraiserIdentificationState> emit,
  ) async {
    emit(state.copyWith(updateFundraiserResult: const ApiResultLoading()));
    final payload = UpdateCampaignFundraiserPaylaod(
        campaignId: event.campaignId,
        idNumber: state.idNumberText,
        signatureFile: state.signatureFile);
    final res = await _updateCampaignFundraiser.call(payload);
    res.fold(
      (failure) => emit(state.copyWith(
          updateFundraiserResult: ApiResultFailure(failure.errorMessage))),
      (campaignFundraiser) => emit(
        state.copyWith(
          updateFundraiserResult: ApiResultSuccess(campaignFundraiser),
          fundraiserResult: ApiResultSuccess(campaignFundraiser),
        ),
      ),
    );
  }

  Future<void> _onFetchCampaignFundraiser(
    OnFetchCampaignFundraiser event,
    Emitter<FundraiserIdentificationState> emit,
  ) async {
    emit(state.copyWith(fundraiserResult: const ApiResultLoading()));
    final res = await _fetchCampaignFundraiser.call(event.campaignId);
    res.fold(
      (failure) => emit(state.copyWith(
          fundraiserResult: ApiResultFailure(failure.errorMessage))),
      (campaignFundraiser) {
        emit(
          state.copyWith(
            fundraiserResult: ApiResultSuccess(campaignFundraiser),
            idNumberText: campaignFundraiser.user.identityNumber ?? '',
          ),
        );
        if (event.onSuccess != null) event.onSuccess!(campaignFundraiser);
      },
    );
  }

  Future<void> _onIdNumberChanged(
    OnIdNumberChanged event,
    Emitter<FundraiserIdentificationState> emit,
  ) async {
    emit(state.copyWith(idNumberText: event.value));
  }

  Future<void> _onSignatureFileChanged(
    OnSignatureFileChanged event,
    Emitter<FundraiserIdentificationState> emit,
  ) async {
    emit(state.copyWith(signatureFile: event.file));
  }
}
