// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_collaboration_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCollaborationPayload _$CreateCollaborationPayloadFromJson(
        Map<String, dynamic> json) =>
    CreateCollaborationPayload(
      reward: (json['reward'] as num).toDouble(),
      campaignId: json['campaignId'] as String,
    );

Map<String, dynamic> _$CreateCollaborationPayloadToJson(
        CreateCollaborationPayload instance) =>
    <String, dynamic>{
      'reward': instance.reward,
      'campaignId': instance.campaignId,
    };
