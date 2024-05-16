import 'package:crowdfunding_flutter/domain/model/age_group.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_category.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_comment.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_donation.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_update.dart';
import 'package:crowdfunding_flutter/domain/model/image/image_model.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/domain/model/state/state_region.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'campaign.g.dart';

@JsonSerializable()
class Campaign {
  final String id;
  final String title;
  final String description;
  final List<ImageModel> images;
  final String? videoUrl;
  final String thumbnailUrl;
  final StateAndRegion stateAndRegion;
  final double targetAmount;
  final String contactPhoneNumber;
  final bool isPublished;
  final String beneficiaryName;
  final String? beneficiaryImageUrl;
  final AgeGroup? beneficiaryAgeGroup;
  final CampaignCategory campaignCategory;
  final Organization? organization;
  final UserModel user;
  final int numOfDonations;
  final int numOfLikes;
  final int numOfComments;
  final int numOfUpdates;
  final String createdAt;
  final String updatedAt;
  final List<CampaignDonation> donations;
  final List<CampaignUpdate> campaignUpdates;
  final List<CampaignComment> comments;

  const Campaign({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    this.videoUrl,
    required this.thumbnailUrl,
    required this.stateAndRegion,
    required this.targetAmount,
    required this.contactPhoneNumber,
    required this.isPublished,
    required this.beneficiaryName,
    this.beneficiaryImageUrl,
    this.beneficiaryAgeGroup,
    required this.campaignCategory,
    this.organization,
    required this.user,
    required this.numOfDonations,
    required this.numOfLikes,
    required this.numOfComments,
    required this.numOfUpdates,
    required this.createdAt,
    required this.updatedAt,
    this.donations = const [],
    this.campaignUpdates = const [],
    this.comments = const [],
  });

  factory Campaign.fromJson(Map<String, dynamic> json) =>
      _$CampaignFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignToJson(this);
}
