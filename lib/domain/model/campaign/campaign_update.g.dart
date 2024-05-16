// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignUpdate _$CampaignUpdateFromJson(Map<String, dynamic> json) =>
    CampaignUpdate(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      campaign: Campaign.fromJson(json['campaign'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
      images: (json['images'] as List<dynamic>)
          .map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CampaignUpdateToJson(CampaignUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'campaign': instance.campaign,
      'createdAt': instance.createdAt,
      'images': instance.images,
      'user': instance.user,
    };
