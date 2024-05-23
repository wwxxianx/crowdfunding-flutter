import 'package:json_annotation/json_annotation.dart';

part 'favourite_campaign_payload.g.dart';

@JsonSerializable()
class FavouriteCampaignPayload {
  final String campaignId;

  const FavouriteCampaignPayload({
    required this.campaignId,
  });

  factory FavouriteCampaignPayload.fromJson(Map<String, dynamic> json) =>
      _$FavouriteCampaignPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteCampaignPayloadToJson(this);
}
