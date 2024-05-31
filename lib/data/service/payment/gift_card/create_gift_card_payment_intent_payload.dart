import 'package:json_annotation/json_annotation.dart';

part 'create_gift_card_payment_intent_payload.g.dart';

@JsonSerializable()
class CreateGiftCardPaymentIntentPayload {
  final String receiverId;
  final int amount;
  final String message;

  const CreateGiftCardPaymentIntentPayload({
    required this.receiverId,
    required this.amount,
    required this.message,
  });

  factory CreateGiftCardPaymentIntentPayload.fromJson(
          Map<String, dynamic> json) =>
      _$CreateGiftCardPaymentIntentPayloadFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateGiftCardPaymentIntentPayloadToJson(this);
}
