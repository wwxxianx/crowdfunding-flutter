import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_favourite_campaign.g.dart';

@JsonSerializable()
class UserFavouriteCampaign {
  final Campaign campaign;
  final String createdAt;

  const UserFavouriteCampaign({
    required this.campaign,
    required this.createdAt,
  });

  factory UserFavouriteCampaign.fromJson(Map<String, dynamic> json) =>
      _$UserFavouriteCampaignFromJson(json);

  Map<String, dynamic> toJson() => _$UserFavouriteCampaignToJson(this);
}
