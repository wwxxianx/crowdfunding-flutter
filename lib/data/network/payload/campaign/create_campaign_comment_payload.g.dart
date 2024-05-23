// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_campaign_comment_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCampaignCommentPayload _$CreateCampaignCommentPayloadFromJson(
        Map<String, dynamic> json) =>
    CreateCampaignCommentPayload(
      campaignId: json['campaignId'] as String,
      comment: json['comment'] as String,
    );

Map<String, dynamic> _$CreateCampaignCommentPayloadToJson(
        CreateCampaignCommentPayload instance) =>
    <String, dynamic>{
      'campaignId': instance.campaignId,
      'comment': instance.comment,
    };
