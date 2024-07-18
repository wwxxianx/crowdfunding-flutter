import 'dart:io';
import 'package:crowdfunding_flutter/common/utils/input_validator.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_donation.dart';
import 'package:equatable/equatable.dart';

final class CreateCampaignState extends Equatable with InputValidator {
  // Details
  final String? targetAmountText;
  final String? targetAmountError;
  final String? selectedCategoryId;
  final String? categoryError;
  final String? selectedStateId;
  final String? stateError;
  final String? phoneNumberText;
  final String? phoneNumberError;
  final DateTime? selectedExpirationDate;
  final String? expirationDateError;

  // Beneficiary
  final String? beneficiaryNameText;
  final String? beneficiaryNameError;
  final File? beneficiaryImageFile;

  // Description
  final String? titleText;
  final String? descriptionText;
  final String? titleError;
  final String? descriptionError;

  // Medias
  final List<File> campaignImageFiles;
  final String? campaignImageError;
  final File? campaignVideoFile;

  // Create campaign
  final ApiResult<CampaignSummary> createCampaignResult;

  const CreateCampaignState._({
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
    this.createCampaignResult = const ApiResultInitial(),
    this.selectedExpirationDate,
    this.expirationDateError,
  });

  const CreateCampaignState.initial() : this._();

  CreateCampaignState copyWith({
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
    ApiResult<CampaignSummary>? createCampaignResult,
    DateTime? selectedExpirationDate,
    String? expirationDateError,
  }) {
    return CreateCampaignState._(
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
      createCampaignResult: createCampaignResult ?? this.createCampaignResult,
      selectedExpirationDate: selectedExpirationDate ?? this.selectedExpirationDate,
      expirationDateError: expirationDateError,
    );
  }

  @override
  List<Object?> get props => [
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
        createCampaignResult,
        selectedExpirationDate,
        expirationDateError,
      ];
}
