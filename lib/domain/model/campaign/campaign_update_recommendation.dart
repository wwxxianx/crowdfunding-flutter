import 'package:json_annotation/json_annotation.dart';

part 'campaign_update_recommendation.g.dart';

@JsonSerializable()
class CampaignUpdateRecommendation {
  final String title;
  final String description;

  const CampaignUpdateRecommendation(
      {required this.title, required this.description});

  factory CampaignUpdateRecommendation.fromJson(Map<String, dynamic> json) =>
      _$CampaignUpdateRecommendationFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignUpdateRecommendationToJson(this);
}
