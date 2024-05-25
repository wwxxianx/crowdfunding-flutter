import 'dart:io';

import 'package:crowdfunding_flutter/domain/model/image/image_model.dart';
import 'package:flutter/material.dart';

@immutable
sealed class EditCampaignEvent {
  const EditCampaignEvent();
}

final class OnFetchCampaign extends EditCampaignEvent {
  final String campaignId;

  OnFetchCampaign({required this.campaignId});
}

final class OnTargetAmountTextChanged extends EditCampaignEvent {
  final String targetAmount;

  const OnTargetAmountTextChanged({required this.targetAmount});
}

final class OnSelectCampaignCategory extends EditCampaignEvent {
  final String categoryId;

  const OnSelectCampaignCategory({required this.categoryId});
}

final class OnSelectState extends EditCampaignEvent {
  final String stateId;

  const OnSelectState({required this.stateId});
}

final class OnPhoneNumberChanged extends EditCampaignEvent {
  final String phoneNumber;

  const OnPhoneNumberChanged({required this.phoneNumber});
}

final class OnBeneficiaryNameChanged extends EditCampaignEvent {
  final String beneficiaryName;

  const OnBeneficiaryNameChanged({required this.beneficiaryName});
}

final class OnBeneficiaryImageFileChanged extends EditCampaignEvent {
  final File? imageFile;

  const OnBeneficiaryImageFileChanged({required this.imageFile});
}

final class OnTitleChanged extends EditCampaignEvent {
  final String title;

  const OnTitleChanged({required this.title});
}

final class OnDescriptionChanged extends EditCampaignEvent {
  final String description;

  const OnDescriptionChanged({required this.description});
}

final class OnCampaignImageFilesChanged extends EditCampaignEvent {
  final List<File>? imageFiles;

  const OnCampaignImageFilesChanged({required this.imageFiles});
}

final class OnCampaignVideoFileChanged extends EditCampaignEvent {
  final File? videoFile;

  const OnCampaignVideoFileChanged({required this.videoFile});
}

final class OnRemoveImage extends EditCampaignEvent {
  final ImageModel image;
  const OnRemoveImage({required this.image});
}

final class ValidateData extends EditCampaignEvent {
  final VoidCallback onSuccess;

  const ValidateData({required this.onSuccess});
}

final class OnUpdateCampaign extends EditCampaignEvent {
  final VoidCallback onSuccess;

  const OnUpdateCampaign({required this.onSuccess});
}
