import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

class CreateCampaignUpdatePayload {
  final String title;
  final String description;
  final String campaignId;
  final List<File> imageFiles;

  const CreateCampaignUpdatePayload({
    required this.title,
    required this.description,
    required this.campaignId,
    required this.imageFiles,
  });
}