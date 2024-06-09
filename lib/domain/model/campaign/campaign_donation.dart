import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'campaign_donation.g.dart';

@JsonSerializable()
class CampaignDonation {
  final String id;
  final UserModel user;
  final int amount;
  final String createdAt;
  final bool isAnonymous;
  final CampaignSummary? campaign;

  const CampaignDonation({
    required this.id,
    required this.user,
    required this.amount,
    required this.createdAt,
    required this.isAnonymous,
    this.campaign,
  });

  factory CampaignDonation.fromJson(Map<String, dynamic> json) =>
      _$CampaignDonationFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignDonationToJson(this);

  @override
  String toString() {
    return """"
    id: $id,
    user: $user,
    amount: $amount,
    createdAt: $createdAt,
    isAnonymous: $isAnonymous,
    """;
  }
}

@JsonSerializable()
class CampaignSummary {
  final String id;
  final String title;
  final String description;
  final String? videoUrl;
  final String thumbnailUrl;
  final double targetAmount;
  final String contactPhoneNumber;
  final String beneficiaryName;
  final String? beneficiaryImageUrl;
  final String createdAt;
  final String updatedAt;

  const CampaignSummary({
    required this.id,
    required this.title,
    required this.description,
    this.videoUrl,
    required this.thumbnailUrl,
    required this.targetAmount,
    required this.contactPhoneNumber,
    required this.beneficiaryName,
    this.beneficiaryImageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CampaignSummary.fromJson(Map<String, dynamic> json) =>
      _$CampaignSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignSummaryToJson(this);

  CampaignSummary copyWith({
    String? id,
    String? title,
    String? description,
    String? videoUrl,
    String? thumbnailUrl,
    double? targetAmount,
    String? contactPhoneNumber,
    bool? isPublished,
    String? beneficiaryName,
    String? beneficiaryImageUrl,
    String? createdAt,
    String? updatedAt,
  }) {
    return CampaignSummary(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      targetAmount: targetAmount ?? this.targetAmount,
      contactPhoneNumber: contactPhoneNumber ?? this.contactPhoneNumber,
      beneficiaryName: beneficiaryName ?? this.beneficiaryName,
      beneficiaryImageUrl: beneficiaryImageUrl ?? this.beneficiaryImageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
