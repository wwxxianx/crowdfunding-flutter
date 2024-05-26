import 'dart:io';

import 'package:flutter/material.dart';

@immutable
sealed class CreateCampaignUpdateEvent {
  const CreateCampaignUpdateEvent();
}

final class OnCreateCampaignUpdate extends CreateCampaignUpdateEvent {
  final String title;
  final String description;
  final String campaignId;
  final List<File> imageFiles;
  final VoidCallback onSuccess;

  const OnCreateCampaignUpdate({
    required this.title,
    required this.description,
    required this.campaignId,
    required this.imageFiles,
    required this.onSuccess,
  });
}
