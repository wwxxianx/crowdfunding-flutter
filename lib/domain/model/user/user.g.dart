// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      address: json['address'] as String?,
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
      onesignalId: json['onesignalId'] as String?,
      bankAccount: json['bankAccount'] == null
          ? null
          : UserBankAccount.fromJson(
              json['bankAccount'] as Map<String, dynamic>),
      identityNumber: json['identityNumber'] as String?,
      identificationStatus: json['identificationStatus'] as String,
      identificationRejectReason: json['identificationRejectReason'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'profileImageUrl': instance.profileImageUrl,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'refreshToken': instance.refreshToken,
      'isOnboardingCompleted': instance.isOnboardingCompleted,
      'identityNumber': instance.identityNumber,
      'identificationStatus': instance.identificationStatus,
      'identificationRejectReason': instance.identificationRejectReason,
      'onesignalId': instance.onesignalId,
      'organization': instance.organization,
      'preference': instance.preference,
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
      address: json['address'] as String?,
      onesignalId: json['onesignalId'] as String?,
      refreshToken: json['refreshToken'] as String? ?? "",
      preference: json['preference'] == null
          ? null
          : UserPreference.fromJson(json['preference'] as Map<String, dynamic>),
      identificationStatus: json['identificationStatus'] as String,
      isOnboardingCompleted: json['isOnboardingCompleted'] as bool? ?? false,
      accessToken: json['accessToken'] as String,
      bankAccount: json['bankAccount'] == null
          ? null
          : UserBankAccount.fromJson(
              json['bankAccount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelWithAccessTokenToJson(
        UserModelWithAccessToken instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'profileImageUrl': instance.profileImageUrl,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'refreshToken': instance.refreshToken,
      'isOnboardingCompleted': instance.isOnboardingCompleted,
      'identificationStatus': instance.identificationStatus,
      'onesignalId': instance.onesignalId,
      'preference': instance.preference,
      'bankAccount': instance.bankAccount,
      'accessToken': instance.accessToken,
    };
