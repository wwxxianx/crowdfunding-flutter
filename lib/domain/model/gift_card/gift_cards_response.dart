import 'package:crowdfunding_flutter/domain/model/gift_card/gift_card.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gift_cards_response.g.dart';

@JsonSerializable()
class GiftCardsResponse {
  final List<GiftCard> sent;
  final List<GiftCard> received;

  const GiftCardsResponse({
    this.sent = const [],
    this.received = const [],
  });

  factory GiftCardsResponse.fromJson(Map<String, dynamic> json) =>
      _$GiftCardsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GiftCardsResponseToJson(this);
}
