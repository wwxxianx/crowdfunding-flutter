import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
sealed class CreateCampaignEvent extends Equatable {
  const CreateCampaignEvent();

  @override
  List<Object> get props => [];
}

final class OnTargetAmountTextChanged extends CreateCampaignEvent {
  final String targetAmount;

  const OnTargetAmountTextChanged({required this.targetAmount});
}

final class OnSelectCampaignCategory extends CreateCampaignEvent {
  final String categoryId;

  const OnSelectCampaignCategory({required this.categoryId});
}

final class OnSelectState extends CreateCampaignEvent {
  final String stateId;

  const OnSelectState({required this.stateId});
}

final class OnPhoneNumberChanged extends CreateCampaignEvent {
  final String phoneNumber;

  const OnPhoneNumberChanged({required this.phoneNumber});
}

final class OnBeneficiaryNameChanged extends CreateCampaignEvent {
  final String beneficiaryName;

  const OnBeneficiaryNameChanged({required this.beneficiaryName});
}

final class OnBeneficiaryImageFileChanged extends CreateCampaignEvent {
  final File? imageFile;

  const OnBeneficiaryImageFileChanged({required this.imageFile});
}

final class OnTitleChanged extends CreateCampaignEvent {
  final String title;

  const OnTitleChanged({required this.title});
}

final class OnDescriptionChanged extends CreateCampaignEvent {
  final String description;

  const OnDescriptionChanged({required this.description});
}

final class OnCampaignImageFilesChanged extends CreateCampaignEvent {
  final List<File>? imageFiles;

  const OnCampaignImageFilesChanged({required this.imageFiles});
}

final class OnCampaignVideoFileChanged extends CreateCampaignEvent {
  final File? videoFile;

  const OnCampaignVideoFileChanged({required this.videoFile});
}

final class ValidateDetailsData extends CreateCampaignEvent {
  final VoidCallback onSuccess;

  const ValidateDetailsData({required this.onSuccess});
}

final class ValidateBeneficiaryData extends CreateCampaignEvent {
  final VoidCallback onSuccess;

  const ValidateBeneficiaryData({required this.onSuccess});
}

final class ValidateDescriptionData extends CreateCampaignEvent {
  final VoidCallback onSuccess;

  const ValidateDescriptionData({required this.onSuccess});
}

final class OnCreateCampaign extends CreateCampaignEvent {
  final void Function(String campaignId) onSuccess;

  const OnCreateCampaign({required this.onSuccess});
}

final class OnExpirationDateChanged extends CreateCampaignEvent {
  final DateTime date;

  const OnExpirationDateChanged({required this.date});
}
