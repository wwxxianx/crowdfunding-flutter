import 'package:json_annotation/json_annotation.dart';

part 'campaign_category.g.dart';

@JsonSerializable()
class CampaignCategory {
  final String id;
  final String title;

  const CampaignCategory({
    required this.id,
    required this.title,
  });

  factory CampaignCategory.fromJson(Map<String, dynamic> json) => _$CampaignCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignCategoryToJson(this);
}