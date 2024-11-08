// ignore_for_file: constant_identifier_names

import 'package:crowdfunding_flutter/domain/model/age_group.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_category.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_comment.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_donation.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_update.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/enum/campaign_enum.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/community_challenge.dart';
import 'package:crowdfunding_flutter/domain/model/image/image_model.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/domain/model/state/state_region.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'campaign.g.dart';

@JsonSerializable()
class Campaign {
  final String id;
  final String status;
  final String? suspendReason;
  final String title;
  final String description;
  final int raisedAmount;
  final List<ImageModel> images;
  final String? videoUrl;
  final String thumbnailUrl;
  final StateAndRegion stateAndRegion;
  final double targetAmount;
  final String contactPhoneNumber;
  final CampaignCategory campaignCategory;
  final Organization? organization;
  final UserModel user;
  // Beneficiary
  final String beneficiaryName;
  final String? beneficiaryImageUrl;
  final AgeGroup? beneficiaryAgeGroup;
  final String createdAt;
  final String updatedAt;
  final String? expiredAt;
  // Fundraiser signature
  final String? fundraiserSignaturFileUrl;
  // Data
  final int numOfDonations;
  final int numOfLikes;
  final int numOfComments;
  final int numOfUpdates;
  final List<CampaignDonation> donations;
  final List<CampaignUpdate> campaignUpdates;
  final List<CampaignComment> comments;
  final List<CampaignDonation> topThreeDonations;
  final List<CampaignDonation> recentThreeDonations;
  final CommunityChallenge? firstMatchedCommunityChallenge;
  //Collaboration
  final Organization? collaboratedOrganization;

  const Campaign({
    required this.id,
    required this.title,
    required this.description,
    this.raisedAmount = 0,
    this.images = const [],
    this.videoUrl,
    required this.thumbnailUrl,
    required this.stateAndRegion,
    required this.targetAmount,
    required this.contactPhoneNumber,
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
    this.topThreeDonations = const [],
    this.recentThreeDonations = const [],
    this.fundraiserSignaturFileUrl,
    this.firstMatchedCommunityChallenge,
    this.status = "PENDING",
    this.suspendReason,
    this.expiredAt,
    this.collaboratedOrganization,
  });

  CampaignPublishStatusEnum get statusEnum {
    try {
      return CampaignPublishStatusEnum.values.byName(status);
    } catch (e) {
      return CampaignPublishStatusEnum.PENDING;
    }
  }

  factory Campaign.fromJson(Map<String, dynamic> json) =>
      _$CampaignFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignToJson(this);

  Campaign copyWith({
    String? id,
    String? title,
    String? description,
    int? raisedAmount,
    List<ImageModel>? images,
    String? videoUrl,
    String? thumbnailUrl,
    StateAndRegion? stateAndRegion,
    double? targetAmount,
    String? contactPhoneNumber,
    bool? isPublished,
    String? beneficiaryName,
    String? beneficiaryImageUrl,
    AgeGroup? beneficiaryAgeGroup,
    CampaignCategory? campaignCategory,
    Organization? organization,
    UserModel? user,
    int? numOfDonations,
    int? numOfLikes,
    int? numOfComments,
    int? numOfUpdates,
    String? createdAt,
    String? updatedAt,
    List<CampaignDonation>? donations,
    List<CampaignUpdate>? campaignUpdates,
    List<CampaignComment>? comments,
    List<CampaignDonation>? topThreeDonations,
    List<CampaignDonation>? recentThreeDonations,
    String? fundraiserSignaturFileUrl,
    CommunityChallenge? firstMatchedCommunityChallenge,
    String? status,
    String? suspendReason,
    String? expiredAt,
    Organization? collaboratedOrganization,
  }) {
    return Campaign(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      images: images ?? this.images,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      stateAndRegion: stateAndRegion ?? this.stateAndRegion,
      targetAmount: targetAmount ?? this.targetAmount,
      contactPhoneNumber: contactPhoneNumber ?? this.contactPhoneNumber,
      beneficiaryName: beneficiaryName ?? this.beneficiaryName,
      beneficiaryImageUrl: beneficiaryImageUrl ?? this.beneficiaryImageUrl,
      beneficiaryAgeGroup: beneficiaryAgeGroup ?? this.beneficiaryAgeGroup,
      campaignCategory: campaignCategory ?? this.campaignCategory,
      organization: organization ?? this.organization,
      user: user ?? this.user,
      numOfDonations: numOfDonations ?? this.numOfDonations,
      numOfLikes: numOfLikes ?? this.numOfLikes,
      numOfComments: numOfComments ?? this.numOfComments,
      numOfUpdates: numOfUpdates ?? this.numOfUpdates,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      donations: donations ?? this.donations,
      campaignUpdates: campaignUpdates ?? this.campaignUpdates,
      comments: comments ?? this.comments,
      topThreeDonations: topThreeDonations ?? this.topThreeDonations,
      recentThreeDonations: recentThreeDonations ?? this.recentThreeDonations,
      raisedAmount: raisedAmount ?? this.raisedAmount,
      fundraiserSignaturFileUrl:
          fundraiserSignaturFileUrl ?? this.fundraiserSignaturFileUrl,
      firstMatchedCommunityChallenge:
          firstMatchedCommunityChallenge ?? this.firstMatchedCommunityChallenge,
      status: status ?? this.status,
      suspendReason: suspendReason ?? this.suspendReason,
      expiredAt: expiredAt ?? this.expiredAt,
      collaboratedOrganization: collaboratedOrganization ?? this.collaboratedOrganization,
    );
  }

  static final sample = Campaign(
    id: 'sample-id',
    title: 'Sample Campaign',
    description: 'This is a sample campaign description.',
    images: [ImageModel.sample, ImageModel.sample],
    videoUrl: '',
    thumbnailUrl:
        'https://yyavkrjmlxoqxeeybxuc.supabase.co/storage/v1/object/public/campaign/thumbnail/larm-rmah-AEaTUnvneik-unsplash.jpg',
    stateAndRegion: StateAndRegion.sample,
    targetAmount: 1000.0,
    contactPhoneNumber: '112189387',
    beneficiaryName: 'Sample Beneficiary',
    beneficiaryImageUrl:
        'https://yyavkrjmlxoqxeeybxuc.supabase.co/storage/v1/object/public/campaign/thumbnail/larm-rmah-AEaTUnvneik-unsplash.jpg',
    beneficiaryAgeGroup: AgeGroup.baby,
    campaignCategory: CampaignCategory.sample,
    user: UserModel.sample,
    numOfDonations: 0,
    createdAt: '2024-05-16T08:21:57.324Z',
    updatedAt: '2024-05-16T08:21:57.324Z',
    numOfComments: 0,
    numOfLikes: 0,
    numOfUpdates: 0,
  );

  static final samples = [
    Campaign(
      id: '1',
      title: 'Sample Campaign',
      description: 'This is a sample campaign description.',
      images: [ImageModel.sample, ImageModel.sample],
      videoUrl: '',
      thumbnailUrl:
          'https://yyavkrjmlxoqxeeybxuc.supabase.co/storage/v1/object/public/campaign/thumbnail/larm-rmah-AEaTUnvneik-unsplash.jpg',
      stateAndRegion: StateAndRegion.sample,
      targetAmount: 1000.0,
      contactPhoneNumber: '112189387',
      beneficiaryName: 'Sample Beneficiary',
      beneficiaryImageUrl:
          'https://yyavkrjmlxoqxeeybxuc.supabase.co/storage/v1/object/public/campaign/thumbnail/larm-rmah-AEaTUnvneik-unsplash.jpg',
      beneficiaryAgeGroup: AgeGroup.baby,
      campaignCategory: CampaignCategory.sample,
      user: UserModel.sample,
      numOfDonations: 0,
      createdAt: '2024-05-16T08:21:57.324Z',
      updatedAt: '2024-05-16T08:21:57.324Z',
      numOfComments: 0,
      numOfLikes: 0,
      numOfUpdates: 0,
    ),
    Campaign(
      id: '2',
      title: 'Sample Campaign',
      description: 'This is a sample campaign description.',
      images: [ImageModel.sample, ImageModel.sample],
      videoUrl: '',
      thumbnailUrl:
          'https://yyavkrjmlxoqxeeybxuc.supabase.co/storage/v1/object/public/campaign/thumbnail/larm-rmah-AEaTUnvneik-unsplash.jpg',
      stateAndRegion: StateAndRegion.sample,
      targetAmount: 1000.0,
      contactPhoneNumber: '112189387',
      beneficiaryName: 'Sample Beneficiary',
      beneficiaryImageUrl:
          'https://yyavkrjmlxoqxeeybxuc.supabase.co/storage/v1/object/public/campaign/thumbnail/larm-rmah-AEaTUnvneik-unsplash.jpg',
      beneficiaryAgeGroup: AgeGroup.baby,
      campaignCategory: CampaignCategory.sample,
      user: UserModel.sample,
      numOfDonations: 0,
      createdAt: '2024-05-16T08:21:57.324Z',
      updatedAt: '2024-05-16T08:21:57.324Z',
      numOfComments: 0,
      numOfLikes: 0,
      numOfUpdates: 0,
    ),
  ];

//   @override
//   String toString() {
//     // TODO: implement toString
//     return """

// """;
//   }
}
