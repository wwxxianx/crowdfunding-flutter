// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_fundraiser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignFundraiser _$CampaignFundraiserFromJson(Map<String, dynamic> json) =>
    CampaignFundraiser(
      campaignId: json['id'] as String,
      fundraiserIdentityNumber: json['fundraiserIdentityNumber'] as String?,
      fundraiserIdentificationStatus:
          json['fundraiserIdentificationStatus'] as String,
      fundraiserIdentificationRejectReason:
          json['fundraiserIdentificationRejectReason'] as String?,
      fundraiserSignaturFileUrl: json['fundraiserSignatureUrl'] as String?,
    );

Map<String, dynamic> _$CampaignFundraiserToJson(CampaignFundraiser instance) =>
    <String, dynamic>{
      'id': instance.campaignId,
      'fundraiserIdentityNumber': instance.fundraiserIdentityNumber,
      'fundraiserIdentificationStatus': instance.fundraiserIdentificationStatus,
      'fundraiserIdentificationRejectReason':
          instance.fundraiserIdentificationRejectReason,
      'fundraiserSignatureUrl': instance.fundraiserSignaturFileUrl,
    };
