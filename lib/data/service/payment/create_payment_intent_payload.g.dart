// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_payment_intent_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePaymentIntentPayload _$CreatePaymentIntentPayloadFromJson(
        Map<String, dynamic> json) =>
    CreatePaymentIntentPayload(
      amount: (json['amount'] as num).toInt(),
      campaignId: json['campaignId'] as String,
      isAnonymous: json['isAnonymous'] as bool,
    );

Map<String, dynamic> _$CreatePaymentIntentPayloadToJson(
        CreatePaymentIntentPayload instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'campaignId': instance.campaignId,
      'isAnonymous': instance.isAnonymous,
    };
