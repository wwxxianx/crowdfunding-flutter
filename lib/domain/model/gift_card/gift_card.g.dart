// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiftCard _$GiftCardFromJson(Map<String, dynamic> json) => GiftCard(
      id: json['id'] as String,
      sender: UserModel.fromJson(json['sender'] as Map<String, dynamic>),
      receiver: UserModel.fromJson(json['receiver'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
      amount: (json['amount'] as num).toInt(),
      message: json['message'] as String,
      campaignDonation: json['campaignDonation'] == null
          ? null
          : CampaignDonation.fromJson(
              json['campaignDonation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GiftCardToJson(GiftCard instance) => <String, dynamic>{
      'id': instance.id,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'createdAt': instance.createdAt,
      'amount': instance.amount,
      'message': instance.message,
      'campaignDonation': instance.campaignDonation,
    };
