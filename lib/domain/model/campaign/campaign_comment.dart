import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'campaign_comment.g.dart';

@JsonSerializable()
class CampaignComment {
  final String id;
  final UserModel user;
  final String comment;
  final String createdAt;
  final String? parentId;
  final List<CampaignComment> replies;

  const CampaignComment({
    required this.id,
    required this.user,
    required this.comment,
    required this.createdAt,
    this.replies = const [],
    this.parentId,
  });

  factory CampaignComment.fromJson(Map<String, dynamic> json) =>
      _$CampaignCommentFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignCommentToJson(this);
}
