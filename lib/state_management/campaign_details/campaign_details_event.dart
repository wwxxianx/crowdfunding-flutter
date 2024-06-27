import 'dart:io';

import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_comment_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_reply_payload.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_comment.dart';
import 'package:flutter/material.dart';

@immutable
sealed class CampaignDetailsEvent {
  const CampaignDetailsEvent();
}

final class OnSubmitComment extends CampaignDetailsEvent {
  final CreateCampaignCommentPayload payload;

  const OnSubmitComment(this.payload);
}

final class OnSubmitReply extends CampaignDetailsEvent {
  final CreateCampaignReplyPayload payload;

  const OnSubmitReply(this.payload);
}

final class OnFetchCampaign extends CampaignDetailsEvent {
  final String campaignId;

  const OnFetchCampaign(this.campaignId);
}

final class OnTabIndexChanged extends CampaignDetailsEvent {
  final int index;

  const OnTabIndexChanged(this.index);
}

final class OnSelectCommentToReply extends CampaignDetailsEvent {
  final CampaignComment campaignComment;

  const OnSelectCommentToReply(this.campaignComment);
}

final class OnClearSelectedCommentToReply extends CampaignDetailsEvent {}

final class OnToggleCommentBottomBar extends CampaignDetailsEvent {
  final bool isShow;

  const OnToggleCommentBottomBar({required this.isShow});
}

final class OnCreateScamReport extends CampaignDetailsEvent {
  final VoidCallback onSuccess;

  const OnCreateScamReport({required this.onSuccess});
}

final class OnScamReportImageFilesChanged extends CampaignDetailsEvent {
  final List<File> imageFiles;

  const OnScamReportImageFilesChanged({required this.imageFiles});
}

final class OnScamReportDocumentFilesChanged extends CampaignDetailsEvent {
  final List<File> documentFiles;

  const OnScamReportDocumentFilesChanged({required this.documentFiles});
}

final class OnScamReportDescriptionChanged extends CampaignDetailsEvent {
  final String value;

  const OnScamReportDescriptionChanged({required this.value});
}
