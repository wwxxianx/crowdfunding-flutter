// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_cards_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiftCardsResponse _$GiftCardsResponseFromJson(Map<String, dynamic> json) =>
    GiftCardsResponse(
      sent: (json['sent'] as List<dynamic>?)
              ?.map((e) => GiftCard.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      received: (json['received'] as List<dynamic>?)
              ?.map((e) => GiftCard.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GiftCardsResponseToJson(GiftCardsResponse instance) =>
    <String, dynamic>{
      'sent': instance.sent,
      'received': instance.received,
    };
