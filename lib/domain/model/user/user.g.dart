// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      profileImageUrl: json['profileImageUrl'] as String? ?? "",
      phoneNumber: json['phoneNumber'] as String? ?? "",
      refreshToken: json['refreshToken'] as String? ?? "",
      isOnboardingCompleted: json['isOnboardingCompleted'] as bool? ?? false,
      organization: json['organization'] == null
          ? null
          : Organization.fromJson(json['organization'] as Map<String, dynamic>),
      preference: json['preference'] == null
          ? null
          : UserPreference.fromJson(json['preference'] as Map<String, dynamic>),
      stripeConnectId: json['stripeConnectId'] as String?,
      bankAccount: json['bankAccount'] == null
          ? null
          : BankAccount.fromJson(json['bankAccount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'profileImageUrl': instance.profileImageUrl,
      'phoneNumber': instance.phoneNumber,
      'refreshToken': instance.refreshToken,
      'isOnboardingCompleted': instance.isOnboardingCompleted,
      'organization': instance.organization,
      'preference': instance.preference,
      'stripeConnectId': instance.stripeConnectId,
      'bankAccount': instance.bankAccount,
    };

UserModelWithAccessToken _$UserModelWithAccessTokenFromJson(
        Map<String, dynamic> json) =>
    UserModelWithAccessToken(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      refreshToken: json['refreshToken'] as String? ?? "",
      preference: json['preference'] == null
          ? null
          : UserPreference.fromJson(json['preference'] as Map<String, dynamic>),
      isOnboardingCompleted: json['isOnboardingCompleted'] as bool? ?? false,
      accessToken: json['accessToken'] as String,
      stripeConnectId: json['stripeConnectId'] as String?,
    );

Map<String, dynamic> _$UserModelWithAccessTokenToJson(
        UserModelWithAccessToken instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'profileImageUrl': instance.profileImageUrl,
      'phoneNumber': instance.phoneNumber,
      'refreshToken': instance.refreshToken,
      'isOnboardingCompleted': instance.isOnboardingCompleted,
      'preference': instance.preference,
      'stripeConnectId': instance.stripeConnectId,
      'accessToken': instance.accessToken,
    };
