// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Campaign _$CampaignFromJson(Map<String, dynamic> json) => Campaign(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      images: (json['images'] as List<dynamic>)
          .map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      videoUrl: json['videoUrl'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String,
      stateAndRegion: StateAndRegion.fromJson(
          json['stateAndRegion'] as Map<String, dynamic>),
      targetAmount: (json['targetAmount'] as num).toDouble(),
      contactPhoneNumber: json['contactPhoneNumber'] as String,
      isPublished: json['isPublished'] as bool,
      beneficiaryName: json['beneficiaryName'] as String,
      beneficiaryImageUrl: json['beneficiaryImageUrl'] as String?,
      beneficiaryAgeGroup:
          $enumDecodeNullable(_$AgeGroupEnumMap, json['beneficiaryAgeGroup']),
      campaignCategory: CampaignCategory.fromJson(
          json['campaignCategory'] as Map<String, dynamic>),
      organization: json['organization'] == null
          ? null
          : Organization.fromJson(json['organization'] as Map<String, dynamic>),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      numOfDonations: (json['numOfDonations'] as num).toInt(),
      numOfLikes: (json['numOfLikes'] as num).toInt(),
      numOfComments: (json['numOfComments'] as num).toInt(),
      numOfUpdates: (json['numOfUpdates'] as num).toInt(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      donations: (json['donations'] as List<dynamic>?)
              ?.map((e) => CampaignDonation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      campaignUpdates: (json['campaignUpdates'] as List<dynamic>?)
              ?.map((e) => CampaignUpdate.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      comments: (json['comments'] as List<dynamic>?)
              ?.map((e) => CampaignComment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      topThreeDonations: (json['topThreeDonations'] as List<dynamic>?)
              ?.map((e) => CampaignDonation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      recentThreeDonations: (json['recentThreeDonations'] as List<dynamic>?)
              ?.map((e) => CampaignDonation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CampaignToJson(Campaign instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'images': instance.images,
      'videoUrl': instance.videoUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'stateAndRegion': instance.stateAndRegion,
      'targetAmount': instance.targetAmount,
      'contactPhoneNumber': instance.contactPhoneNumber,
      'isPublished': instance.isPublished,
      'beneficiaryName': instance.beneficiaryName,
      'beneficiaryImageUrl': instance.beneficiaryImageUrl,
      'beneficiaryAgeGroup': _$AgeGroupEnumMap[instance.beneficiaryAgeGroup],
      'campaignCategory': instance.campaignCategory,
      'organization': instance.organization,
      'user': instance.user,
      'numOfDonations': instance.numOfDonations,
      'numOfLikes': instance.numOfLikes,
      'numOfComments': instance.numOfComments,
      'numOfUpdates': instance.numOfUpdates,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'donations': instance.donations,
      'campaignUpdates': instance.campaignUpdates,
      'comments': instance.comments,
      'topThreeDonations': instance.topThreeDonations,
      'recentThreeDonations': instance.recentThreeDonations,
    };

const _$AgeGroupEnumMap = {
  AgeGroup.baby: 'baby',
  AgeGroup.child: 'child',
  AgeGroup.youngAdult: 'youngAdult',
  AgeGroup.midAndAgedAdult: 'midAndAgedAdult',
};
