import 'package:flutter/foundation.dart';

@immutable
sealed class CampaignCollaborationEvent {
  const CampaignCollaborationEvent();
}

final class OnFetchCampaignCollaboration extends CampaignCollaborationEvent {
  final String campaignId;

  const OnFetchCampaignCollaboration({required this.campaignId});
}

final class OnSubmitCampaignCollaboration extends CampaignCollaborationEvent {
  final bool isUpdate;
  final VoidCallback onSuccess;
  final String? campaignId;
  final double reward;

  const OnSubmitCampaignCollaboration({
    required this.onSuccess,
    this.campaignId,
    required this.reward,
    required this.isUpdate,
  });
}
