import 'package:json_annotation/json_annotation.dart';

part 'payment_intent_response.g.dart';

@JsonSerializable()
class PaymentIntentResponse {
  final String clientSecret;
  final String ephemeralKey;
  final String customer;
  final String publishableKey;

  const PaymentIntentResponse({
    required this.clientSecret,
    required this.ephemeralKey,
    required this.customer,
    required this.publishableKey,
  });

  factory PaymentIntentResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentIntentResponseToJson(this);
}
