// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_favourite_campaign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFavouriteCampaign _$UserFavouriteCampaignFromJson(
        Map<String, dynamic> json) =>
    UserFavouriteCampaign(
      campaign: Campaign.fromJson(json['campaign'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$UserFavouriteCampaignToJson(
        UserFavouriteCampaign instance) =>
    <String, dynamic>{
      'campaign': instance.campaign,
      'createdAt': instance.createdAt,
    };
