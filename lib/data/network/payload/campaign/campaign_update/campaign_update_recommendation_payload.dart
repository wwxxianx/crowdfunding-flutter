import 'package:json_annotation/json_annotation.dart';

part 'campaign_update_recommendation_payload.g.dart';

@JsonSerializable()
class CampaignUpdateRecommendationPayload {
  final String campaignId;
  final String topic;

  const CampaignUpdateRecommendationPayload({
    required this.campaignId,
    required this.topic,
  });

  factory CampaignUpdateRecommendationPayload.fromJson(
          Map<String, dynamic> json) =>
      _$CampaignUpdateRecommendationPayloadFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CampaignUpdateRecommendationPayloadToJson(this);
}
