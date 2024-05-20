import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String? profileImageUrl;
  final String? phoneNumber;
  final String refreshToken;
  final bool isOnboardingCompleted;
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
    this.isOnboardingCompleted = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  static const sample = UserModel(
    id: 'sample-id',
    fullName: 'John Doe',
    email: 'john@gmail.com',
  );
}

@JsonSerializable()
class UserModelWithAccessToken extends UserModel {
  final String accessToken;

  const UserModelWithAccessToken({
    required String id,
    required String fullName,
    required String email,
    required this.accessToken,
  }) : super(
          id: id,
          fullName: fullName,
          email: email,
        );

  factory UserModelWithAccessToken.fromJson(Map<String, dynamic> json) =>
      _$UserModelWithAccessTokenFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelWithAccessTokenToJson(this);
}
