// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityChallenge _$CommunityChallengeFromJson(Map<String, dynamic> json) =>
    CommunityChallenge(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      requirements: (json['requirements'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      rule: json['rule'] as String,
      imageUrl: json['imageUrl'] as String,
      termsAndConditions: json['termsAndConditions'] as String,
      targetCampaignCategories:
          (json['targetCampaignCategories'] as List<dynamic>?)
              ?.map((e) => CampaignCategory.fromJson(e as Map<String, dynamic>))
              .toList(),
      challengeType: json['challengeType'] as String,
      rewardCollectMethod: json['rewardCollectMethod'] as String,
      reward: json['reward'] as String,
      sponsorImageUrl: json['sponsorImageUrl'] as String?,
      sponsorName: json['sponsorName'] as String,
      requiredNumOfDonation: (json['requiredNumOfDonation'] as num?)?.toInt(),
      requiredDonationAmount: (json['requiredDonationAmount'] as num?)?.toInt(),
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => ChallengeParticipant.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String,
      expiredAt: json['expiredAt'] as String,
    );

Map<String, dynamic> _$CommunityChallengeToJson(CommunityChallenge instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'requirements': instance.requirements,
      'rule': instance.rule,
      'termsAndConditions': instance.termsAndConditions,
      'imageUrl': instance.imageUrl,
      'targetCampaignCategories': instance.targetCampaignCategories,
      'challengeType': instance.challengeType,
      'rewardCollectMethod': instance.rewardCollectMethod,
      'reward': instance.reward,
      'sponsorImageUrl': instance.sponsorImageUrl,
      'sponsorName': instance.sponsorName,
      'requiredNumOfDonation': instance.requiredNumOfDonation,
      'requiredDonationAmount': instance.requiredDonationAmount,
      'participants': instance.participants,
      'createdAt': instance.createdAt,
      'expiredAt': instance.expiredAt,
    };
