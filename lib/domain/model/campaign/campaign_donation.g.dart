// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_donation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignDonation _$CampaignDonationFromJson(Map<String, dynamic> json) =>
    CampaignDonation(
      id: json['id'] as String,
      campaign: Campaign.fromJson(json['campaign'] as Map<String, dynamic>),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      amount: (json['amount'] as num).toDouble(),
      createdAt: json['createdAt'] as String,
      isAnonymous: json['isAnonymous'] as bool,
    );

Map<String, dynamic> _$CampaignDonationToJson(CampaignDonation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'campaign': instance.campaign,
      'user': instance.user,
      'amount': instance.amount,
      'createdAt': instance.createdAt,
      'isAnonymous': instance.isAnonymous,
    };
