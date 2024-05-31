import 'package:crowdfunding_flutter/domain/model/campaign/campaign_donation.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gift_card.g.dart';

@JsonSerializable()
class GiftCard {
  final String id;
  final UserModel sender;
  final UserModel receiver;
  final String createdAt;
  final int amount;
  final String message;
  final CampaignDonation? campaignDonation;

  const GiftCard({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.createdAt,
    required this.amount,
    required this.message,
    this.campaignDonation,
  });

  factory GiftCard.fromJson(Map<String, dynamic> json) =>
      _$GiftCardFromJson(json);

  Map<String, dynamic> toJson() => _$GiftCardToJson(this);

  static const sample = GiftCard(
    id: "1",
    amount: 500,
    createdAt: "2024-05-16T08:21:57.324Z",
    message: "Wish you ...",
    sender: UserModel.sample,
    receiver: UserModel.sample,
  );

  @override
  String toString() => """
  id: $id,
  sender: $sender,
  receiver: $receiver,
  createdAt: $createdAt,
  amount: $amount,
  message: $message,
  donation: $campaignDonation,
  """;
}
