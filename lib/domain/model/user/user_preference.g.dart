// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreference _$UserPreferenceFromJson(Map<String, dynamic> json) =>
    UserPreference(
      id: json['id'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      favouriteCampaignCategories:
          (json['favouriteCampaignCategories'] as List<dynamic>)
              .map((e) => CampaignCategory.fromJson(e as Map<String, dynamic>))
              .toList(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$UserPreferenceToJson(UserPreference instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'favouriteCampaignCategories': instance.favouriteCampaignCategories,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };