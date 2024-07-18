import 'package:crowdfunding_flutter/common/utils/input_validator.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_payload.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/create_campaign.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign/create_campaign_event.dart';
import 'package:crowdfunding_flutter/state_management/create_campaign/create_campaign_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCampaignBloc extends Bloc<CreateCampaignEvent, CreateCampaignState>
    with InputValidator {
  final CreateCampaign _createCampaign;
  CreateCampaignBloc({
    required CreateCampaign createCampaign,
  })  : _createCampaign = createCampaign,
        super(const CreateCampaignState.initial()) {
    on<CreateCampaignEvent>(_onEvent);
  }

  Future<void> _onEvent(
      CreateCampaignEvent event, Emitter<CreateCampaignState> emit) async {
    return switch (event) {
      final OnTargetAmountTextChanged e => _onTargetAmountTextChanged(e, emit),
      final OnSelectCampaignCategory e => _onSelectCampaignCategory(e, emit),
      final OnSelectState e => _onSelectState(e, emit),
      final OnPhoneNumberChanged e => _onPhoneNumberChanged(e, emit),
      final OnBeneficiaryNameChanged e => _onBeneficiaryNameChanged(e, emit),
      final OnBeneficiaryImageFileChanged e =>
        _onBeneficiaryImageFIleChanged(e, emit),
      final OnTitleChanged e => _onTitleChanged(e, emit),
      final OnDescriptionChanged e => _onDescriptionChanged(e, emit),
      final OnCampaignImageFilesChanged e =>
        __onCampaignImageFilesChanged(e, emit),
      final OnCampaignVideoFileChanged e =>
        _onCampaignVideoFileChanged(e, emit),
      final ValidateDetailsData e => _validateDetailsData(e, emit),
      final ValidateBeneficiaryData e => _validateBeneficiaryData(e, emit),
      final ValidateDescriptionData e => _validateDescriptionData(e, emit),
      final OnCreateCampaign e => _onCreateCampaign(e, emit),
      final OnExpirationDateChanged e => _onExpirationDateChanged(e, emit),
    };
  }

  void _onExpirationDateChanged(
    OnExpirationDateChanged event,
    Emitter<CreateCampaignState> emit,
  ) {
    emit(state.copyWith(selectedExpirationDate: event.date));
  }

  Future<void> _onCreateCampaign(
    OnCreateCampaign event,
    Emitter emit,
  ) async {
    emit(state.copyWith(createCampaignResult: const ApiResultLoading()));
    if (state.campaignImageFiles.isEmpty) {
      emit(state.copyWith(
          createCampaignResult:
              ApiResultFailure('Please upload campaign images')));
      return;
    }
    final payload = CreateCampaignPayload(
      title: state.titleText ?? "",
      description: state.descriptionText ?? "",
      targetAmount: int.parse(state.targetAmountText ?? 0.toString()),
      categoryId: state.selectedCategoryId ?? '',
      phoneNumber: state.phoneNumberText ?? "",
      stateId: state.selectedStateId ?? "",
      beneficiaryName: state.beneficiaryNameText ?? "",
      campaignImageFiles: state.campaignImageFiles,
      campaignVideoFile: state.campaignVideoFile,
      beneficiaryImageFile: state.beneficiaryImageFile,
      expiredAt: state.selectedExpirationDate ?? DateTime.now(),
    );
    final res = await _createCampaign.call(payload);
    res.fold(
      (failure) => emit(state.copyWith(
          createCampaignResult: ApiResultFailure(failure.errorMessage))),
      (campaign) {
        emit(state.copyWith(createCampaignResult: ApiResultSuccess(campaign)));
        event.onSuccess(campaign.id);
      },
    );
  }

  void __onCampaignImageFilesChanged(
    OnCampaignImageFilesChanged event,
    Emitter emit,
  ) {
    emit(state.copyWith(campaignImageFiles: event.imageFiles));
  }

  void _onCampaignVideoFileChanged(
    OnCampaignVideoFileChanged event,
    Emitter emit,
  ) {
    emit(state.copyWith(campaignVideoFile: event.videoFile));
  }

  void _onTargetAmountTextChanged(
    OnTargetAmountTextChanged event,
    Emitter emit,
  ) {
    emit(state.copyWith(targetAmountText: event.targetAmount));
  }

  void _onSelectCampaignCategory(
    OnSelectCampaignCategory event,
    Emitter emit,
  ) {
    emit(state.copyWith(selectedCategoryId: event.categoryId));
  }

  void _onSelectState(
    OnSelectState event,
    Emitter emit,
  ) {
    emit(state.copyWith(selectedStateId: event.stateId));
  }

  void _onPhoneNumberChanged(
    OnPhoneNumberChanged event,
    Emitter emit,
  ) {
    emit(state.copyWith(phoneNumberText: event.phoneNumber));
  }

  void _onBeneficiaryNameChanged(
    OnBeneficiaryNameChanged event,
    Emitter emit,
  ) {
    emit(state.copyWith(beneficiaryNameText: event.beneficiaryName));
  }

  void _onBeneficiaryImageFIleChanged(
    OnBeneficiaryImageFileChanged event,
    Emitter emit,
  ) {
    emit(state.copyWith(beneficiaryImageFile: event.imageFile));
  }

  void _onTitleChanged(
    OnTitleChanged event,
    Emitter emit,
  ) {
    emit(state.copyWith(titleText: event.title));
  }

  void _onDescriptionChanged(
    OnDescriptionChanged event,
    Emitter emit,
  ) {
    emit(state.copyWith(descriptionText: event.description));
  }

  void _validateDetailsData(
    ValidateDetailsData event,
    Emitter emit,
  ) {
    final targetAmountResult =
        validateCampaignTargetAmount(state.targetAmountText);
    final phoneNumberResult = validatePhoneNumber(state.phoneNumberText);
    final stateResult = validateState(state.selectedCategoryId);
    final categoryResult = validateCampaignCategory(state.selectedCategoryId);
    final expirationResult =
        validateCampaignExpirationDate(state.selectedExpirationDate);
    final hasError = List.of([
      targetAmountResult,
      phoneNumberResult,
      stateResult,
      categoryResult,
      expirationResult,
    ]).any((element) => !element.successful);

    if (hasError) {
      emit(state.copyWith(
        targetAmountError: targetAmountResult.errorMessage,
        phoneNumberError: phoneNumberResult.errorMessage,
        stateError: stateResult.errorMessage,
        categoryError: categoryResult.errorMessage,
        expirationDateError: expirationResult.errorMessage,
      ));
      return;
    }
    emit(state.copyWith(
      targetAmountError: null,
      phoneNumberError: null,
      stateError: null,
      categoryError: null,
      expirationDateError: null,
    ));
    event.onSuccess();
  }

  void _validateBeneficiaryData(
    ValidateBeneficiaryData event,
    Emitter emit,
  ) {
    final beneficiaryNameResult = validateFullName(state.beneficiaryNameText);

    if (!beneficiaryNameResult.successful) {
      emit(state.copyWith(
        beneficiaryNameError: beneficiaryNameResult.errorMessage,
      ));
      return;
    }
    emit(state.copyWith(
      beneficiaryNameError: null,
    ));
    event.onSuccess();
  }

  void _validateDescriptionData(
    ValidateDescriptionData event,
    Emitter emit,
  ) {
    final titleResult = validateStringWithMinMaxLength(
      title: "Campaign title",
      value: state.titleText,
      minLength: InputValidator.campaignTitleMinLength,
      maxLength: InputValidator.campaignTitleMaxLength,
    );
    final descriptionResult = validateStringWithMinMaxLength(
      title: "Campaign content",
      value: state.descriptionText,
      minLength: InputValidator.campaignDescriptionMinLength,
      maxLength: InputValidator.campaignDescriptionMaxLength,
    );
    final hasError = List.of([
      titleResult,
      descriptionResult,
    ]).any((element) => !element.successful);

    if (hasError) {
      emit(state.copyWith(
        titleError: titleResult.errorMessage,
        descriptionError: descriptionResult.errorMessage,
      ));
      return;
    }
    emit(state.copyWith(
      titleError: null,
      descriptionError: null,
    ));
    event.onSuccess();
  }
}
