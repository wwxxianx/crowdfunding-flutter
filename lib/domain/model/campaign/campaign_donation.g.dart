// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_donation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignDonation _$CampaignDonationFromJson(Map<String, dynamic> json) =>
    CampaignDonation(
      id: json['id'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      amount: (json['amount'] as num).toInt(),
      createdAt: json['createdAt'] as String,
      isAnonymous: json['isAnonymous'] as bool,
    );

Map<String, dynamic> _$CampaignDonationToJson(CampaignDonation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'amount': instance.amount,
      'createdAt': instance.createdAt,
      'isAnonymous': instance.isAnonymous,
    };
