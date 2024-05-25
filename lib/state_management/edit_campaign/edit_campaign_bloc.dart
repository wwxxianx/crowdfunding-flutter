import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/update_campaign_payload.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/image/image_model.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/fetch_campaign.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/update_campaign.dart';
import 'package:crowdfunding_flutter/state_management/edit_campaign/edit_campaign_event.dart';
import 'package:crowdfunding_flutter/state_management/edit_campaign/edit_campaign_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class EditCampaignBloc extends Bloc<EditCampaignEvent, EditCampaignState> {
  final FetchCampaign _fetchCampaign;
  final UpdateCampaign _updateCampaign;
  EditCampaignBloc({
    required FetchCampaign fetchCampaign,
    required UpdateCampaign updateCampaign,
  })  : _fetchCampaign = fetchCampaign,
        _updateCampaign = updateCampaign,
        super(const EditCampaignState.initial()) {
    on<EditCampaignEvent>(_onEvent);
  }

  Future<void> _onEvent(
    EditCampaignEvent event,
    Emitter<EditCampaignState> emit,
  ) async {
    return switch (event) {
      final OnFetchCampaign e => _onFetchCampaign(e, emit),
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
      final ValidateData e => _validateData(e, emit),
      final OnRemoveImage e => _onRemoveImage(e, emit),
      final OnUpdateCampaign e => _onUpdateCampaign(e, emit),
    };
  }

  Future<void> _onUpdateCampaign(
    OnUpdateCampaign event,
    Emitter emit,
  ) async {
    emit(state.copyWith(
      updateCampaignResult: const ApiResultLoading(),
    ));
    final campaignResult = state.campaignResult;
    if (campaignResult is ApiResultSuccess<Campaign>) {
      final payload = UpdateCampaignPayload(
        campaignId: campaignResult.data.id,
        title: state.titleText ?? campaignResult.data.title,
        description: state.descriptionText ?? campaignResult.data.description,
        targetAmount: state.targetAmountText != null
            ? int.parse(state.targetAmountText!)
            : campaignResult.data.targetAmount.toInt(),
        categoryId:
            state.selectedCategoryId ?? campaignResult.data.campaignCategory.id,
        phoneNumber:
            state.phoneNumberText ?? campaignResult.data.contactPhoneNumber,
        stateId: state.selectedStateId ?? campaignResult.data.stateAndRegion.id,
        beneficiaryName:
            state.beneficiaryNameText ?? campaignResult.data.beneficiaryName,
        newCampaignImageFiles: state.campaignImageFiles,
        newBeneficiaryImageFile: state.beneficiaryImageFile,
        newCampaignVideoFile: state.campaignVideoFile,
        oriBeneficiaryImageUrl: campaignResult.data.beneficiaryImageUrl,
        oriCampaignImagesId:
            campaignResult.data.images.map((image) => image.id).toList(),
      );
      final res = await _updateCampaign.call(payload);
      res.fold(
        (l) => null,
        (r) {
          emit(state.copyWith(updateCampaignResult: const ApiResultInitial()));
          event.onSuccess();
        },
      );
    }
  }

  void _onRemoveImage(
    OnRemoveImage event,
    Emitter emit,
  ) {
    final campaignResult = state.campaignResult;
    List<ImageModel> updatedImages;
    if (campaignResult is ApiResultSuccess<Campaign>) {
      if (campaignResult.data.images.isNotEmpty) {
        updatedImages = campaignResult.data.images
            .where((image) => image.id != event.image.id)
            .toList();
        emit(state.copyWith(
          campaignResult: ApiResultSuccess(
              campaignResult.data.copyWith(images: updatedImages)),
        ));
      }
    }
  }

  void _validateData(
    ValidateData event,
    Emitter emit,
  ) {}

  // Future<void> _onCreateCampaign(
  //   OnCreateCampaign event,
  //   Emitter emit,
  // ) async {
  //   emit(state.copyWith(isCreatingCampaign: true));
  //   if (state.campaignImageFiles.isEmpty) {
  //     emit(state.copyWith(
  //       campaignImageError: 'Please select at least one image',
  //       isCreatingCampaign: false,
  //     ));
  //     return;
  //   }
  //   final payload = CreateCampaignPayload(
  //     title: state.titleText!,
  //     description: state.descriptionText!,
  //     targetAmount: int.parse(state.targetAmountText!),
  //     categoryId: state.selectedCategoryId!,
  //     phoneNumber: state.phoneNumberText!,
  //     stateId: state.selectedStateId!,
  //     beneficiaryName: state.beneficiaryNameText!,
  //     campaignImageFiles: state.campaignImageFiles,
  //     campaignVideoFile: state.campaignVideoFile,
  //     beneficiaryImageFile: state.beneficiaryImageFile,
  //   );
  //   final res = await _createCampaign.call(payload);
  //   res.fold(
  //     (l) => emit(state.copyWith(
  //         createCampaignError: l.errorMessage, isCreatingCampaign: false)),
  //     (r) {
  //       emit(state.copyWith(
  //           createCampaignError: null, isCreatingCampaign: false));
  //       event.onSuccess();
  //     },
  //   );
  // }

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

  Future<void> _onFetchCampaign(
    OnFetchCampaign event,
    Emitter<EditCampaignState> emit,
  ) async {
    emit(const EditCampaignState.fetchCampaignInProgress());
    final res = await _fetchCampaign(event.campaignId);
    res.fold(
      (failure) =>
          emit(EditCampaignState.fetchCampaignFailure(failure.errorMessage)),
      (campaign) {
        emit(EditCampaignState.fetchCampaignSuccess(data: campaign));
        _initDataFields(campaign, emit);
      },
    );
  }

  void _initDataFields(Campaign campaign, Emitter<EditCampaignState> emit) {
    var logger = Logger();
    logger.w(campaign);
    logger.w(campaign.campaignCategory);
    logger.w(campaign.campaignCategory.id);
    emit(state.copyWith(
      targetAmountText: campaign.targetAmount.toInt().toString(),
      selectedCategoryId: campaign.campaignCategory.id,
      selectedStateId: campaign.stateAndRegion.id,
      phoneNumberText: campaign.contactPhoneNumber,
      beneficiaryNameText: campaign.beneficiaryName,
      titleText: campaign.title,
      descriptionText: campaign.description,
      isInitiatingDataFields: true,
    ));
  }
}
