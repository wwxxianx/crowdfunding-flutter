import 'package:crowdfunding_flutter/domain/model/campaign/campaign_category.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
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

  factory UserPreference.fromJson(Map<String, dynamic> json) =>
      _$UserPreferenceFromJson(json);

  Map<String, dynamic> toJson() => _$UserPreferenceToJson(this);
}
