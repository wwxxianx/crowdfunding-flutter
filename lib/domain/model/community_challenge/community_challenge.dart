// ignore_for_file: constant_identifier_names

import 'package:crowdfunding_flutter/domain/model/campaign/campaign_category.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/challenge_participant.dart';
import 'package:crowdfunding_flutter/domain/model/image/image_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community_challenge.g.dart';

enum CommunityChallengeType { DONATION, PHOTO }

enum ChallengeRewardCollectMethod { EMAIL }

@JsonSerializable()
class CommunityChallenge {
  final String id;
  final String title;
  final String description;
  final List<String> requirements;
  final String rule;
  final String termsAndConditions;
  final String imageUrl;
  final List<CampaignCategory>? targetCampaignCategories;
  final String challengeType;
  final String rewardCollectMethod;
  final String reward;
  final String? sponsorImageUrl;
  final String sponsorName;
  final int? requiredNumOfDonation;
  final int? requiredDonationAmount;
  final List<ChallengeParticipant>? participants;
  final String createdAt;
  final String expiredAt;

  const CommunityChallenge({
    required this.id,
    required this.title,
    required this.description,
    required this.requirements,
    required this.rule,
    required this.imageUrl,
    required this.termsAndConditions,
    this.targetCampaignCategories,
    required this.challengeType,
    required this.rewardCollectMethod,
    required this.reward,
    this.sponsorImageUrl,
    required this.sponsorName,
    this.requiredNumOfDonation,
    this.requiredDonationAmount,
    required this.participants,
    required this.createdAt,
    required this.expiredAt,
  });

  factory CommunityChallenge.fromJson(Map<String, dynamic> json) =>
      _$CommunityChallengeFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityChallengeToJson(this);

  static final samples = [
    CommunityChallenge(
      id: "1",
      title: "Community Challenge 1",
      description:
          "Create original posts, stories, or videos highlighting our campaigns and their impact. Be creative and informative",
      requirements: [
        'Create original posts, stories, or videos highlighting our campaigns and their impact. Be creative and informative!',
        'Provide hashtag of #EngageForChange #ChallengeForGood.',
        'Upload a photo of your posts through our challenge submission form.',
      ],
      rule:
          "Upload a photo of your posts about any campaign with hashtags #EngageForChange #ChallengeForGood.",
      reward: "2 TGV movie ticket",
      termsAndConditions: "",
      imageUrl: ImageModel.sample.imageUrl,
      targetCampaignCategories: [],
      challengeType: "PHOTO",
      rewardCollectMethod: "EMAIL",
      sponsorImageUrl: ImageModel.sample.imageUrl,
      sponsorName: "TGV",
      requiredNumOfDonation: 1,
      requiredDonationAmount: 20,
      participants: [],
      createdAt: "2024-05-16T08:21:57.324Z",
      expiredAt: "2024-07-16T08:21:57.324Z",
    ),
    CommunityChallenge(
      id: "1",
      title: "Community Challenge 1",
      description:
          "Create original posts, stories, or videos highlighting our campaigns and their impact. Be creative and informative",
      requirements: [],
      rule: "Donate to 2 campaign",
      reward: "2 TGV movie ticket",
      termsAndConditions: "",
      imageUrl: ImageModel.sample.imageUrl,
      targetCampaignCategories: [],
      challengeType: "DONATION",
      rewardCollectMethod: "EMAIL",
      sponsorImageUrl: ImageModel.sample.imageUrl,
      sponsorName: "TGV",
      requiredNumOfDonation: 1,
      requiredDonationAmount: 20,
      participants: [],
      createdAt: "2024-05-16T08:21:57.324Z",
      expiredAt: "2024-07-16T08:21:57.324Z",
    ),
  ];
}

extension CommunityChallengeExtension on CommunityChallenge {
  String get displayRule {
    final challengeType =
        CommunityChallengeType.values.byName(this.challengeType);
    if (challengeType == CommunityChallengeType.PHOTO) {
      return rule;
    }
    String donationRule = "Donate to ${requiredNumOfDonation} campaign.";
    if (requiredDonationAmount != null) {
      donationRule += " RM${requiredDonationAmount} for each donation.";
    } else {
      donationRule += " No amount requirement for each donation.";
    }
    if (targetCampaignCategories?.isNotEmpty ?? false) {
      donationRule += " Campaign must be type of ";
      for (var category in targetCampaignCategories!) {
        donationRule += "${category.title}, ";
      }
    }
    return donationRule;
  }
}
