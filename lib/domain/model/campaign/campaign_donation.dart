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

  const CampaignDonation({
    required this.id,
    required this.user,
    required this.amount,
    required this.createdAt,
    required this.isAnonymous,
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
