import 'package:json_annotation/json_annotation.dart';

part 'num_gift_card_response.g.dart';

@JsonSerializable()
class NumOfGiftCardsResponse {
  final int numOfGiftCards;

  const NumOfGiftCardsResponse({
    required this.numOfGiftCards,
  });

  factory NumOfGiftCardsResponse.fromJson(Map<String, dynamic> json) => _$NumOfGiftCardsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NumOfGiftCardsResponseToJson(this);
}