// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_collaboration_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCollaborationPayload _$UpdateCollaborationPayloadFromJson(
        Map<String, dynamic> json) =>
    UpdateCollaborationPayload(
      collaborationId: json['collaborationId'] as String,
      organizationId: json['organizationId'] as String?,
      reward: (json['reward'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UpdateCollaborationPayloadToJson(
        UpdateCollaborationPayload instance) =>
    <String, dynamic>{
      'collaborationId': instance.collaborationId,
      'organizationId': instance.organizationId,
      'reward': instance.reward,
    };
