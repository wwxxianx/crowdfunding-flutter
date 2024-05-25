import 'package:json_annotation/json_annotation.dart';

part 'create_payment_intent_payload.g.dart';

@JsonSerializable()
class CreatePaymentIntentPayload {
  final int amount;
  final String campaignId;
  final bool isAnonymous;

  const CreatePaymentIntentPayload({
    required this.amount,
    required this.campaignId,
    required this.isAnonymous,
  });

  factory CreatePaymentIntentPayload.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentIntentPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePaymentIntentPayloadToJson(this);
}
