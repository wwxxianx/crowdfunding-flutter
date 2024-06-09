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
      campaign: json['campaign'] == null
          ? null
          : CampaignSummary.fromJson(json['campaign'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CampaignDonationToJson(CampaignDonation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'amount': instance.amount,
      'createdAt': instance.createdAt,
      'isAnonymous': instance.isAnonymous,
      'campaign': instance.campaign,
    };

CampaignSummary _$CampaignSummaryFromJson(Map<String, dynamic> json) =>
    CampaignSummary(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      videoUrl: json['videoUrl'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String,
      targetAmount: (json['targetAmount'] as num).toDouble(),
      contactPhoneNumber: json['contactPhoneNumber'] as String,
      beneficiaryName: json['beneficiaryName'] as String,
      beneficiaryImageUrl: json['beneficiaryImageUrl'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$CampaignSummaryToJson(CampaignSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'videoUrl': instance.videoUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'targetAmount': instance.targetAmount,
      'contactPhoneNumber': instance.contactPhoneNumber,
      'beneficiaryName': instance.beneficiaryName,
      'beneficiaryImageUrl': instance.beneficiaryImageUrl,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
