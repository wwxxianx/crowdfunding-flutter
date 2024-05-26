import 'package:crowdfunding_flutter/common/utils/input_validator.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/campaign_update/create_campaign_update_payload.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/campaign_update/create_campaign_update.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign_update/create_campaign_update_event.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign_update/create_campaign_update_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCampaignUpdateBloc
    extends Bloc<CreateCampaignUpdateEvent, CreateCampaignUpdateState>
    with InputValidator {
  final CreateCampaignUpdate _createCampaignUpdate;
  CreateCampaignUpdateBloc({
    required CreateCampaignUpdate createCampaignUpdate,
  })  : _createCampaignUpdate = createCampaignUpdate,
        super(const CreateCampaignUpdateState.initial()) {
    on<CreateCampaignUpdateEvent>(_onEvent);
  }

  Future<void> _onEvent(
    CreateCampaignUpdateEvent event,
    Emitter<CreateCampaignUpdateState> emit,
  ) async {
    return switch (event) {
      final OnCreateCampaignUpdate e => _onCreateCampaignUpdate(e, emit),
    };
  }

  Future<void> _onCreateCampaignUpdate(
    OnCreateCampaignUpdate event,
    Emitter<CreateCampaignUpdateState> emit,
  ) async {
    emit(state.copyWith(createUpdateResult: const ApiResultLoading()));
    // Validate
    final titleError = validateStringWithMinMaxLength(
      title: "Update title",
      value: event.title,
      minLength: 1,
      maxLength: 100,
    );
    final descriptionError = validateStringWithMinMaxLength(
      title: "Content",
      value: event.description,
      minLength: 100,
      maxLength: 1000,
    );
    final hasError =
        [titleError, descriptionError].any((result) => !result.successful);
    if (hasError) {
      emit(state.copyWith(createUpdateResult: const ApiResultInitial()));
      return;
    }
    final payload = CreateCampaignUpdatePayload(
      title: event.title,
      description: event.description,
      campaignId: event.campaignId,
      imageFiles: event.imageFiles,
    );
    final res = await _createCampaignUpdate(payload);
    res.fold(
      (failure) => emit(state.copyWith(createUpdateResult: ApiResultFailure(failure.errorMessage))),
      (campaignUpdate) {
        emit(state.copyWith(createUpdateResult: ApiResultSuccess(campaignUpdate)));
        event.onSuccess();
      },
    );
  }
}
