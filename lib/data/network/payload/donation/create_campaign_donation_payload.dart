import 'package:json_annotation/json_annotation.dart';

part 'create_campaign_donation_payload.g.dart';

@JsonSerializable()
class CreateGiftCardDonationPayload {
  final String campaignId;
  final bool isAnonymous;
  final String giftCardId;

  const CreateGiftCardDonationPayload({
    required this.campaignId,
    required this.isAnonymous,
    required this.giftCardId,
  });

  factory CreateGiftCardDonationPayload.fromJson(Map<String, dynamic> json) =>
      _$CreateGiftCardDonationPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGiftCardDonationPayloadToJson(this);
}
