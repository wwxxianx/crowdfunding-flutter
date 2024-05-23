import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_comment_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_reply_payload.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_comment.dart';
import 'package:flutter/material.dart';

@immutable
sealed class CampaignDetailsEvent {}

final class OnSubmitComment extends CampaignDetailsEvent {
  final CreateCampaignCommentPayload payload;

  OnSubmitComment(this.payload);
}

final class OnSubmitReply extends CampaignDetailsEvent {
  final CreateCampaignReplyPayload payload;

  OnSubmitReply(this.payload);
}

final class OnFetchCampaign extends CampaignDetailsEvent {
  final String campaignId;

  OnFetchCampaign(this.campaignId);
}

final class OnTabIndexChanged extends CampaignDetailsEvent {
  final int index;

  OnTabIndexChanged(this.index);
}

final class OnSelectCommentToReply extends CampaignDetailsEvent {
  final CampaignComment campaignComment;

  OnSelectCommentToReply(this.campaignComment);
}

final class OnClearSelectedCommentToReply extends CampaignDetailsEvent {}