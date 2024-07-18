// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_fundraiser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignFundraiser _$CampaignFundraiserFromJson(Map<String, dynamic> json) =>
    CampaignFundraiser(
      campaignId: json['id'] as String,
      fundraiserSignaturFileUrl: json['fundraiserSignatureUrl'] as String?,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CampaignFundraiserToJson(CampaignFundraiser instance) =>
    <String, dynamic>{
      'id': instance.campaignId,
      'fundraiserSignatureUrl': instance.fundraiserSignaturFileUrl,
      'user': instance.user,
    };
