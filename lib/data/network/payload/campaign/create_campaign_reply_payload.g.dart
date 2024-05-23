// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_campaign_reply_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCampaignReplyPayload _$CreateCampaignReplyPayloadFromJson(
        Map<String, dynamic> json) =>
    CreateCampaignReplyPayload(
      campaignId: json['campaignId'] as String,
      parentId: json['parentId'] as String,
      comment: json['comment'] as String,
    );

Map<String, dynamic> _$CreateCampaignReplyPayloadToJson(
        CreateCampaignReplyPayload instance) =>
    <String, dynamic>{
      'campaignId': instance.campaignId,
      'parentId': instance.parentId,
      'comment': instance.comment,
    };
