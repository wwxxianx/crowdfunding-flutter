// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_campaign_donation_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGiftCardDonationPayload _$CreateGiftCardDonationPayloadFromJson(
        Map<String, dynamic> json) =>
    CreateGiftCardDonationPayload(
      campaignId: json['campaignId'] as String,
      isAnonymous: json['isAnonymous'] as bool,
      giftCardId: json['giftCardId'] as String,
    );

Map<String, dynamic> _$CreateGiftCardDonationPayloadToJson(
        CreateGiftCardDonationPayload instance) =>
    <String, dynamic>{
      'campaignId': instance.campaignId,
      'isAnonymous': instance.isAnonymous,
      'giftCardId': instance.giftCardId,
    };
