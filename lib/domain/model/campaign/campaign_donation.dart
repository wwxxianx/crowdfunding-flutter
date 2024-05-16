import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'campaign_donation.g.dart';

@JsonSerializable()
class CampaignDonation {
  final String id;
  final Campaign campaign;
  final UserModel user;
  final double amount;
  final String createdAt;
  final bool isAnonymous;

  const CampaignDonation({
    required this.id,
    required this.campaign,
    required this.user,
    required this.amount,
    required this.createdAt,
    required this.isAnonymous,
  });

  factory CampaignDonation.fromJson(Map<String, dynamic> json) =>
      _$CampaignDonationFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignDonationToJson(this);
}
