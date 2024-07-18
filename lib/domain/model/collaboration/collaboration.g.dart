// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collaboration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collaboration _$CollaborationFromJson(Map<String, dynamic> json) =>
    Collaboration(
      id: json['id'] as String,
      campaign: Campaign.fromJson(json['campaign'] as Map<String, dynamic>),
      organization: json['organization'] == null
          ? null
          : Organization.fromJson(json['organization'] as Map<String, dynamic>),
      reward: (json['reward'] as num).toDouble(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      isCancelled: json['isCancelled'] as bool? ?? false,
      cancelledById: json['cancelledById'] as String?,
      cancellationReason: json['cancellationReason'] as String?,
      cancelledAt: json['cancelledAt'] as String?,
    );

Map<String, dynamic> _$CollaborationToJson(Collaboration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'campaign': instance.campaign,
      'organization': instance.organization,
      'reward': instance.reward,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'isCancelled': instance.isCancelled,
      'cancelledById': instance.cancelledById,
      'cancellationReason': instance.cancellationReason,
      'cancelledAt': instance.cancelledAt,
    };
