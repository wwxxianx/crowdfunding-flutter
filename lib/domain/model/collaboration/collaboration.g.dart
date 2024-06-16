// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collaboration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collaboration _$CollaborationFromJson(Map<String, dynamic> json) =>
    Collaboration(
      id: json['id'] as String,
      campaign:
          CampaignSummary.fromJson(json['campaign'] as Map<String, dynamic>),
      organization: json['organization'] == null
          ? null
          : Organization.fromJson(json['organization'] as Map<String, dynamic>),
      reward: (json['reward'] as num).toDouble(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$CollaborationToJson(Collaboration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'campaign': instance.campaign,
      'organization': instance.organization,
      'reward': instance.reward,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
