import 'dart:io';

import 'package:crowdfunding_flutter/data/network/payload/campaign/campaign_update/campaign_update_recommendation_payload.dart';
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

final class OnCreateCampaignUpdateRecommendation
    extends CreateCampaignUpdateEvent {
  final CampaignUpdateRecommendationPayload payload;

  const OnCreateCampaignUpdateRecommendation({required this.payload});
}
