import 'package:json_annotation/json_annotation.dart';

part 'giftcard_donation_response.g.dart';

@JsonSerializable()
class GiftCardDonationResponse {
  final bool result;

  const GiftCardDonationResponse({
    required this.result,
  });

  factory GiftCardDonationResponse.fromJson(Map<String, dynamic> json) => _$GiftCardDonationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GiftCardDonationResponseToJson(this);
}