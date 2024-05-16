import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String? profileImageUrl;
  final String? phoneNumber;
  final String? refreshToken;
  // UserPreference? preference;
  // List<CampaignDonation> campaignDonations;
  // List<Campaign> campaigns;
  // List<CampaignComment> campaignComments;
  // List<UserFavouriteCampaign> favouriteCampaigns;
  // List<Notification> notifications;
  // List<CampaignUpdate> campaignUpdates;
  // Organization? organization;
  // String? organizationId;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.profileImageUrl = "",
    this.phoneNumber = "",
    this.refreshToken = "",
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
