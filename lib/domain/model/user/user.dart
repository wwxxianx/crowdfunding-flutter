import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/domain/model/user/bank_account.dart';
import 'package:crowdfunding_flutter/domain/model/user/user_preference.dart';
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
  final String? identityNumber;
  final String identificationStatus;
  final String? identificationRejectReason;
  final Organization? organization;
  final UserPreference? preference;
  // final String? stripeConnectId;
  final UserBankAccount? bankAccount;
  // List<CampaignDonation> campaignDonations;
  // List<Campaign> campaigns;
  // List<CampaignComment> campaignComments;
  // List<UserFavouriteCampaign> favouriteCampaigns;
  // List<Notification> notifications;
  // List<CampaignUpdate> campaignUpdates;
  // String? organizationId;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.profileImageUrl = "",
    this.phoneNumber = "",
    this.refreshToken = "",
    this.isOnboardingCompleted = false,
    this.organization,
    this.preference,
    // this.stripeConnectId,
    this.bankAccount,
    this.identityNumber,
    required this.identificationStatus,
    this.identificationRejectReason,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  static final sample = UserModel(
    id: 'sample-id',
    fullName: 'John Doe',
    email: 'john@gmail.com',
    preference: UserPreference.samples.first,
    identificationStatus: "PENDING"
  );

  @override
  String toString() => """
  id: $id,
  fullName: $fullName,
  email: $email,
  profileImageUrl: $profileImageUrl,
  phoneNumber: $phoneNumber,
  refreshToken: $refreshToken,
  isOnboardingCompleted: $isOnboardingCompleted,
  """;
}

@JsonSerializable()
class UserModelWithAccessToken extends UserModel {
  final String accessToken;

  const UserModelWithAccessToken({
    required String id,
    required String fullName,
    required String email,
    String? profileImageUrl,
    String? phoneNumber,
    String refreshToken = "",
    UserPreference? preference,
    required String identificationStatus,
    bool isOnboardingCompleted = false,
    required this.accessToken,
    // String? stripeConnectId,
    UserBankAccount? bankAccount,
  }) : super(
          id: id,
          fullName: fullName,
          email: email,
          isOnboardingCompleted: isOnboardingCompleted,
          profileImageUrl: profileImageUrl,
          phoneNumber: phoneNumber,
          refreshToken: refreshToken,
          preference: preference,
          // stripeConnectId: stripeConnectId,
          identificationStatus: identificationStatus,
          bankAccount: bankAccount,
        );

  UserModel toUserModel() {
    return UserModel(
      id: id,
      fullName: fullName,
      email: email,
      profileImageUrl: profileImageUrl,
      phoneNumber: phoneNumber ?? "",
      refreshToken: refreshToken,
      isOnboardingCompleted: isOnboardingCompleted,
      preference: preference,
      // stripeConnectId: stripeConnectId,
      identificationStatus: identificationStatus,
      bankAccount: bankAccount,
    );
  }

  @override
  String toString() => """
  id: $id,
  fullName: $fullName,
  email: $email,
  profileImageUrl: $profileImageUrl,
  phoneNumber: $phoneNumber,
  refreshToken: $refreshToken,
  isOnboardingCompleted: $isOnboardingCompleted,
  """;

  factory UserModelWithAccessToken.fromJson(Map<String, dynamic> json) =>
      _$UserModelWithAccessTokenFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserModelWithAccessTokenToJson(this);
}
