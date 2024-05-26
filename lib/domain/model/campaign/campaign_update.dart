import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/image/image_model.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'campaign_update.g.dart';

@JsonSerializable()
class CampaignUpdate {
  final String id;
  final String title;
  final String description;
  final String createdAt;
  final List<ImageModel>? images;
  final UserModel user;

  const CampaignUpdate({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.images,
    required this.user,
  });

  factory CampaignUpdate.fromJson(Map<String, dynamic> json) =>
      _$CampaignUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignUpdateToJson(this);
}
