// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Campaign _$CampaignFromJson(Map<String, dynamic> json) => Campaign(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      raisedAmount: (json['raisedAmount'] as num?)?.toInt() ?? 0,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      videoUrl: json['videoUrl'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String,
      stateAndRegion: StateAndRegion.fromJson(
          json['stateAndRegion'] as Map<String, dynamic>),
      targetAmount: (json['targetAmount'] as num).toDouble(),
      contactPhoneNumber: json['contactPhoneNumber'] as String,
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
      fundraiserSignaturFileUrl: json['fundraiserSignaturFileUrl'] as String?,
      firstMatchedCommunityChallenge: json['firstMatchedCommunityChallenge'] ==
              null
          ? null
          : CommunityChallenge.fromJson(
              json['firstMatchedCommunityChallenge'] as Map<String, dynamic>),
      status: json['status'] as String? ?? "PENDING",
      suspendReason: json['suspendReason'] as String?,
      expiredAt: json['expiredAt'] as String?,
    );

Map<String, dynamic> _$CampaignToJson(Campaign instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'suspendReason': instance.suspendReason,
      'title': instance.title,
      'description': instance.description,
      'raisedAmount': instance.raisedAmount,
      'images': instance.images,
      'videoUrl': instance.videoUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'stateAndRegion': instance.stateAndRegion,
      'targetAmount': instance.targetAmount,
      'contactPhoneNumber': instance.contactPhoneNumber,
      'campaignCategory': instance.campaignCategory,
      'organization': instance.organization,
      'user': instance.user,
      'beneficiaryName': instance.beneficiaryName,
      'beneficiaryImageUrl': instance.beneficiaryImageUrl,
      'beneficiaryAgeGroup': _$AgeGroupEnumMap[instance.beneficiaryAgeGroup],
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'expiredAt': instance.expiredAt,
      'fundraiserSignaturFileUrl': instance.fundraiserSignaturFileUrl,
      'numOfDonations': instance.numOfDonations,
      'numOfLikes': instance.numOfLikes,
      'numOfComments': instance.numOfComments,
      'numOfUpdates': instance.numOfUpdates,
      'donations': instance.donations,
      'campaignUpdates': instance.campaignUpdates,
      'comments': instance.comments,
      'topThreeDonations': instance.topThreeDonations,
      'recentThreeDonations': instance.recentThreeDonations,
      'firstMatchedCommunityChallenge': instance.firstMatchedCommunityChallenge,
    };

const _$AgeGroupEnumMap = {
  AgeGroup.baby: 'baby',
  AgeGroup.child: 'child',
  AgeGroup.youngAdult: 'youngAdult',
  AgeGroup.midAndAgedAdult: 'midAndAgedAdult',
};
