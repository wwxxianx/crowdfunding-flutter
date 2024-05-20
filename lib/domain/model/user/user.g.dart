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
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'profileImageUrl': instance.profileImageUrl,
      'phoneNumber': instance.phoneNumber,
      'refreshToken': instance.refreshToken,
      'isOnboardingCompleted': instance.isOnboardingCompleted,
    };

UserModelWithAccessToken _$UserModelWithAccessTokenFromJson(
        Map<String, dynamic> json) =>
    UserModelWithAccessToken(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      accessToken: json['accessToken'] as String,
    );

Map<String, dynamic> _$UserModelWithAccessTokenToJson(
        UserModelWithAccessToken instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'accessToken': instance.accessToken,
    };
