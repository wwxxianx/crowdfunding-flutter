import 'package:equatable/equatable.dart';

final class CreateCampaignState extends Equatable {
  // Fetch data

  // Step1
  final String? targetAmountText;
  final String? selectedCategoryId;
  final String? selectedLocationId;
  final String? phoneNumberText;

  // Step2
  final String? beneficiaryNameText;

  // Step3
  final String? titleText;
  final String? descriptionText;

  const CreateCampaignState._({
    this.targetAmountText,
    this.selectedCategoryId,
    this.selectedLocationId,
    this.phoneNumberText,
    this.beneficiaryNameText,
    this.titleText,
    this.descriptionText,
  });

  const CreateCampaignState.initial() : this._();

  CreateCampaignState copyWith({
    String? targetAmountText,
    String? selectedCategoryId,
    String? selectedLocationId,
    String? phoneNumberText,
    String? beneficiaryNameText,
    String? titleText,
    String? descriptionText,
  }) {
    return CreateCampaignState._(
      targetAmountText: targetAmountText ?? this.targetAmountText,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      selectedLocationId: selectedLocationId ?? this.selectedLocationId,
      phoneNumberText: phoneNumberText ?? this.phoneNumberText,
      beneficiaryNameText: beneficiaryNameText ?? this.beneficiaryNameText,
      titleText: titleText ?? this.titleText,
      descriptionText: descriptionText ?? this.descriptionText,
    );
  }

  @override
  List<Object?> get props => [
        targetAmountText,
        selectedCategoryId,
        selectedLocationId,
        phoneNumberText,
        beneficiaryNameText,
        titleText,
        descriptionText,
      ];
}
