
import 'package:json_annotation/json_annotation.dart';

part 'create_campaign_comment_payload.g.dart';

@JsonSerializable()
class CreateCampaignCommentPayload {
  final String campaignId;
  final String comment;

  const CreateCampaignCommentPayload({
    required this.campaignId,
    required this.comment,
  });

  factory CreateCampaignCommentPayload.fromJson(Map<String, dynamic> json) => _$CreateCampaignCommentPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCampaignCommentPayloadToJson(this);
}