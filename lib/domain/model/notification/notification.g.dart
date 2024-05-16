// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      id: json['id'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      title: json['title'] as String,
      description: json['description'] as String,
      meta: json['meta'] as Map<String, dynamic>?,
      actor: UserModel.fromJson(json['actor'] as Map<String, dynamic>),
      entityId: json['entityId'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'title': instance.title,
      'description': instance.description,
      'meta': instance.meta,
      'actor': instance.actor,
      'entityId': instance.entityId,
      'createdAt': instance.createdAt,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.campaignUpdate: 'campaignUpdate',
  NotificationType.campaignDonation: 'campaignDonation',
  NotificationType.campaignComment: 'campaignComment',
  NotificationType.coin: 'coin',
};
