import 'package:crowdfunding_flutter/domain/model/campaign/campaign_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_preference.g.dart';

@JsonSerializable()
class UserPreference {
  final String id;
  final List<CampaignCategory> favouriteCampaignCategories;
  final String createdAt;
  final String updatedAt;

  const UserPreference({
    required this.id,
    required this.favouriteCampaignCategories,
    required this.createdAt,
    required this.updatedAt,
  });

  static const samples = [
    UserPreference(
      id: '1',
      favouriteCampaignCategories: CampaignCategory.samples,
      createdAt: '2020-01-01T00:00:00.000Z',
      updatedAt: '2020-01-01T00:00:00.000Z',
    ),
    UserPreference(
      id: '2',
      favouriteCampaignCategories: CampaignCategory.samples,
      createdAt: '2020-01-01T00:00:00.000Z',
      updatedAt: '2020-01-01T00:00:00.000Z',
    ),
  ];

  factory UserPreference.fromJson(Map<String, dynamic> json) =>
      _$UserPreferenceFromJson(json);

  Map<String, dynamic> toJson() => _$UserPreferenceToJson(this);
}
