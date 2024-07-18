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

  factory CampaignCategory.fromJson(Map<String, dynamic> json) =>
      _$CampaignCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignCategoryToJson(this);

  static const sample = CampaignCategory(id: '1', title: 'medical');
  static const samples = [
    CampaignCategory(id: '1', title: 'medical'),
    CampaignCategory(id: '2', title: 'education'),
    CampaignCategory(id: '3', title: 'emergency'),
  ];
}
