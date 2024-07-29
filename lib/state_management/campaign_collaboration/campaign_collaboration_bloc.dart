import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/collaboration/create_collaboration_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/collaboration/fetch_collaboration_filter.dart';
import 'package:crowdfunding_flutter/data/network/payload/collaboration/update_collaboration_payload.dart';
import 'package:crowdfunding_flutter/domain/model/collaboration/collaboration.dart';
import 'package:crowdfunding_flutter/domain/usecases/collaboration/create_campaign_collaboration.dart';
import 'package:crowdfunding_flutter/domain/usecases/collaboration/fetch_collaborations.dart';
import 'package:crowdfunding_flutter/domain/usecases/collaboration/update_campaign_collaboration.dart';
import 'package:crowdfunding_flutter/state_management/campaign_collaboration/campaign_collaboration_event.dart';
import 'package:crowdfunding_flutter/state_management/campaign_collaboration/campaign_collaboration_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CampaignCollaborationBloc
    extends Bloc<CampaignCollaborationEvent, CampaignCollaborationState> {
  final CreateCampaignCollaboration _createCampaignCollaboration;
  final UpdateCampaignCollaboration _updateCampaignCollaboration;
  final FetchCollaborations _fetchCollaborations;

  CampaignCollaborationBloc({
    required CreateCampaignCollaboration createCampaignCollaboration,
    required UpdateCampaignCollaboration updateCampaignCollaboration,
    required FetchCollaborations fetchCollaborations,
  })  : _fetchCollaborations = fetchCollaborations,
        _createCampaignCollaboration = createCampaignCollaboration,
        _updateCampaignCollaboration = updateCampaignCollaboration,
        super(const CampaignCollaborationState.initial()) {
    on<CampaignCollaborationEvent>(_onEvent);
  }

  Future<void> _onEvent(
    CampaignCollaborationEvent event,
    Emitter<CampaignCollaborationState> emit,
  ) async {
    return switch (event) {
      final OnFetchCampaignCollaboration e =>
        _onFetchCampaignCollaboration(e, emit),
      final OnSubmitCampaignCollaboration e =>
        _onCreateCampaignCollaboration(e, emit),
    };
  }

  Future<void> _onCreateCampaignCollaboration(
    OnSubmitCampaignCollaboration event,
    Emitter<CampaignCollaborationState> emit,
  ) async {
    emit(state.copyWith(submitCollaborationResult: const ApiResultLoading()));
    if (event.isUpdate) {
      final campaignCollaborationResult =
          state.campaignCollaborationResult as ApiResultSuccess<Collaboration>;
      final payload = UpdateCollaborationPayload(
          collaborationId: campaignCollaborationResult.data.id,
          reward: event.reward);
      final res = await _updateCampaignCollaboration.call(payload);
      res.fold(
        (failure) {
          emit(state.copyWith(
              submitCollaborationResult:
                  ApiResultFailure(failure.errorMessage)));
        },
        (collaboration) {
          emit(state.copyWith(
            submitCollaborationResult: ApiResultSuccess(collaboration),
            campaignCollaborationResult: ApiResultSuccess(collaboration),
          ));
          event.onSuccess();
        },
      );
    } else {
      final payload = CreateCollaborationPayload(
          campaignId: event.campaignId ?? '', reward: event.reward);
      final res = await _createCampaignCollaboration.call(payload);
      res.fold(
        (failure) {
          emit(state.copyWith(
              submitCollaborationResult:
                  ApiResultFailure(failure.errorMessage)));
        },
        (collaboration) {
          emit(state.copyWith(
            submitCollaborationResult: ApiResultSuccess(collaboration),
            campaignCollaborationResult: ApiResultSuccess(collaboration),
          ));
          event.onSuccess();
        },
      );
    }
  }

  Future<void> _onFetchCampaignCollaboration(
    OnFetchCampaignCollaboration event,
    Emitter<CampaignCollaborationState> emit,
  ) async {
    // emit(state.copyWith(
    //   campaignCollaborationResult:
    //       ApiResultSuccess(Collaboration.samples.first),
    // ));
    final filter = FetchCollaborationFilter(
      campaignId: event.campaignId,
    );
    final res = await _fetchCollaborations.call(filter);
    res.fold(
      (failure) => emit(state.copyWith(campaignCollaborationResult: ApiResultFailure(failure.errorMessage))),
      (campaignCollaboration) {
        if (campaignCollaboration.isEmpty) {
          emit(
            state.copyWith(
              campaignCollaborationResult: const ApiResultInitial(),
              isCollarationNull: true,
            ),
          );
          return;
        }
        emit(
          state.copyWith(
            campaignCollaborationResult:
                ApiResultSuccess(campaignCollaboration.first),
            isCollarationNull: false,
          ),
        );
      },
    );
  }
}
