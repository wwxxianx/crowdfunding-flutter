import 'package:json_annotation/json_annotation.dart';

part 'create_campaign_donation_payment_intent_payload.g.dart';

@JsonSerializable()
class CreateCampaignDonationPaymentIntentPayload {
  final int amount;
  final String campaignId;
  final bool isAnonymous;
  final String? giftCardId;

  const CreateCampaignDonationPaymentIntentPayload({
    required this.amount,
    required this.campaignId,
    required this.isAnonymous,
    this.giftCardId,
  });

  factory CreateCampaignDonationPaymentIntentPayload.fromJson(
          Map<String, dynamic> json) =>
      _$CreateCampaignDonationPaymentIntentPayloadFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateCampaignDonationPaymentIntentPayloadToJson(this);
}
