// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_campaign_donation_payment_intent_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCampaignDonationPaymentIntentPayload
    _$CreateCampaignDonationPaymentIntentPayloadFromJson(
            Map<String, dynamic> json) =>
        CreateCampaignDonationPaymentIntentPayload(
          amount: (json['amount'] as num).toInt(),
          campaignId: json['campaignId'] as String,
          isAnonymous: json['isAnonymous'] as bool,
          giftCardId: json['giftCardId'] as String?,
        );

Map<String, dynamic> _$CreateCampaignDonationPaymentIntentPayloadToJson(
        CreateCampaignDonationPaymentIntentPayload instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'campaignId': instance.campaignId,
      'isAnonymous': instance.isAnonymous,
      'giftCardId': instance.giftCardId,
    };
