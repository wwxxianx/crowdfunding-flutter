import 'package:crowdfunding_flutter/domain/model/campaign/campaign_donation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_grouped_donations_response.g.dart';

@JsonSerializable()
class UserDonationsResponse {
  final Map<String, List<CampaignDonation>> groupedDonations;

  const UserDonationsResponse({
    required this.groupedDonations,
  });

  factory UserDonationsResponse.fromJson(Map<String, dynamic> json) => _$UserDonationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserDonationsResponseToJson(this);
}