import 'dart:io';

import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:equatable/equatable.dart';

final class EditCampaignState extends Equatable {
  final ApiResult<Campaign> campaignResult;
  final bool isInitiatingDataFields;
  // Step1
  final String? targetAmountText;
  final String? targetAmountError;
  final String? selectedCategoryId;
  final String? categoryError;
  final String? selectedStateId;
  final String? stateError;
  final String? phoneNumberText;
  final String? phoneNumberError;

  // Step2
  final String? beneficiaryNameText;
  final String? beneficiaryNameError;
  final File? beneficiaryImageFile;

  // Step3
  final String? titleText;
  final String? descriptionText;
  final String? titleError;
  final String? descriptionError;

  // Step4
  final List<File> campaignImageFiles;
  final String? campaignImageError;
  final File? campaignVideoFile;

  // Update
  final ApiResult<Campaign> updateCampaignResult;

  const EditCampaignState._({
    required this.campaignResult,
    this.targetAmountText,
    this.selectedCategoryId,
    this.selectedStateId,
    this.phoneNumberText,
    this.beneficiaryNameText,
    this.titleText,
    this.descriptionText,
    this.beneficiaryImageFile,
    this.campaignImageFiles = const [],
    this.campaignVideoFile,
    this.beneficiaryNameError,
    this.targetAmountError,
    this.categoryError,
    this.stateError,
    this.phoneNumberError,
    this.titleError,
    this.descriptionError,
    this.campaignImageError,
    this.isInitiatingDataFields = false,
    this.updateCampaignResult = const ApiResultInitial(),
  });

  const EditCampaignState.initial()
      : this._(campaignResult: const ApiResultInitial());
  const EditCampaignState.fetchCampaignInProgress()
      : this._(campaignResult: const ApiResultLoading());
  EditCampaignState.fetchCampaignSuccess({required Campaign data})
      : this._(campaignResult: ApiResultSuccess(data));
  EditCampaignState.fetchCampaignFailure(String? errorMessage)
      : this._(campaignResult: ApiResultFailure(errorMessage));

  EditCampaignState copyWith({
    ApiResult<Campaign>? campaignResult,
    String? targetAmountText,
    String? selectedCategoryId,
    String? selectedStateId,
    String? phoneNumberText,
    String? beneficiaryNameText,
    String? beneficiaryNameError,
    String? titleText,
    String? descriptionText,
    String? targetAmountError,
    String? categoryError,
    String? stateError,
    String? phoneNumberError,
    File? beneficiaryImageFile,
    File? campaignVideoFile,
    List<File>? campaignImageFiles,
    String? titleError,
    String? descriptionError,
    String? campaignImageError,
    bool? isInitiatingDataFields,
    ApiResult<Campaign>? updateCampaignResult,
  }) {
    return EditCampaignState._(
      campaignResult: campaignResult ?? this.campaignResult,
      targetAmountText: targetAmountText ?? this.targetAmountText,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      selectedStateId: selectedStateId ?? this.selectedStateId,
      phoneNumberText: phoneNumberText ?? this.phoneNumberText,
      beneficiaryNameText: beneficiaryNameText ?? this.beneficiaryNameText,
      beneficiaryNameError: beneficiaryNameError,
      titleText: titleText ?? this.titleText,
      descriptionText: descriptionText ?? this.descriptionText,
      targetAmountError: targetAmountError,
      categoryError: categoryError,
      stateError: stateError,
      phoneNumberError: phoneNumberError,
      campaignImageFiles: campaignImageFiles ?? this.campaignImageFiles,
      beneficiaryImageFile: beneficiaryImageFile ?? this.beneficiaryImageFile,
      campaignVideoFile: campaignVideoFile ?? this.campaignVideoFile,
      titleError: titleError,
      descriptionError: descriptionError,
      campaignImageError: campaignImageError,
      isInitiatingDataFields:
          isInitiatingDataFields ?? this.isInitiatingDataFields,
      updateCampaignResult: updateCampaignResult ?? this.updateCampaignResult,
    );
  }

  @override
  List<Object?> get props => [
        campaignResult,
        targetAmountText,
        selectedCategoryId,
        selectedStateId,
        phoneNumberText,
        beneficiaryNameText,
        beneficiaryNameError,
        titleText,
        descriptionText,
        targetAmountError,
        categoryError,
        stateError,
        phoneNumberError,
        beneficiaryImageFile,
        campaignImageFiles,
        campaignVideoFile,
        titleError,
        descriptionError,
        campaignImageError,
        isInitiatingDataFields,
        updateCampaignResult,
      ];
}