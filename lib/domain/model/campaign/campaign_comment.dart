import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'campaign_comment.g.dart';

@JsonSerializable()
class CampaignComment {
  final String id;
  final UserModel user;
  final Campaign campaign;
  final String comment;
  final String createdAt;
  final List<CampaignComment> replies;

  const CampaignComment({
    required this.id,
    required this.user,
    required this.campaign,
    required this.comment,
    required this.createdAt,
    this.replies = const [],
  });

  factory CampaignComment.fromJson(Map<String, dynamic> json) =>
      _$CampaignCommentFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignCommentToJson(this);
}
