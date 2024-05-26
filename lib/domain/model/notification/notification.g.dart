// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      title: json['title'] as String,
      description: json['description'] as String?,
      meta: json['meta'] as Map<String, dynamic>?,
      actor: json['actor'] == null
          ? null
          : UserModel.fromJson(json['actor'] as Map<String, dynamic>),
      entityId: json['entityId'] as String,
      createdAt: json['createdAt'] as String,
      actorImageUrl: json['actorImageUrl'] as String?,
      campaignImageUrl: json['campaignImageUrl'] as String?,
      coinEarned: json['coinEarned'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'title': instance.title,
      'description': instance.description,
      'meta': instance.meta,
      'actor': instance.actor,
      'entityId': instance.entityId,
      'createdAt': instance.createdAt,
      'actorImageUrl': instance.actorImageUrl,
      'campaignImageUrl': instance.campaignImageUrl,
      'coinEarned': instance.coinEarned,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.campaignUpdate: 'campaignUpdate',
  NotificationType.campaignDonation: 'campaignDonation',
  NotificationType.campaignComment: 'campaignComment',
  NotificationType.coin: 'coin',
};
