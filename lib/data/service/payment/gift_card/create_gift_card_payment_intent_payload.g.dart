// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_gift_card_payment_intent_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGiftCardPaymentIntentPayload _$CreateGiftCardPaymentIntentPayloadFromJson(
        Map<String, dynamic> json) =>
    CreateGiftCardPaymentIntentPayload(
      receiverId: json['receiverId'] as String,
      amount: (json['amount'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$CreateGiftCardPaymentIntentPayloadToJson(
        CreateGiftCardPaymentIntentPayload instance) =>
    <String, dynamic>{
      'receiverId': instance.receiverId,
      'amount': instance.amount,
      'message': instance.message,
    };
