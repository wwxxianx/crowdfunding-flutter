// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Organization _$OrganizationFromJson(Map<String, dynamic> json) => Organization(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      slogan: json['slogan'] as String?,
      imageUrl: json['imageUrl'] as String,
      contactPhoneNumber: json['contactPhoneNumber'] as String,
      invitationCode: json['invitationCode'] as String,
      isVerified: json['isVerified'] as bool,
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      campaigns: (json['campaigns'] as List<dynamic>?)
              ?.map((e) => Campaign.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdBy: UserModel.fromJson(json['createdBy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrganizationToJson(Organization instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'slogan': instance.slogan,
      'contactPhoneNumber': instance.contactPhoneNumber,
      'isVerified': instance.isVerified,
      'imageUrl': instance.imageUrl,
      'invitationCode': instance.invitationCode,
      'members': instance.members,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'campaigns': instance.campaigns,
      'createdBy': instance.createdBy,
    };
