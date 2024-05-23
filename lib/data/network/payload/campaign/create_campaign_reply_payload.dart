import 'package:json_annotation/json_annotation.dart';

part 'create_campaign_reply_payload.g.dart';

@JsonSerializable()
class CreateCampaignReplyPayload {
  final String campaignId;
  // Which comment to reply
  final String parentId;
  final String comment;

  const CreateCampaignReplyPayload({
    required this.campaignId,
    required this.parentId,
    required this.comment,
  });

  CreateCampaignReplyPayload copyWith({
    String? campaignId,
    String? parentId,
    String? comment,
  }) {
    return CreateCampaignReplyPayload(
      campaignId: campaignId ?? this.campaignId,
      parentId: parentId ?? this.parentId,
      comment: comment ?? this.comment,
    );
  }

  factory CreateCampaignReplyPayload.fromJson(Map<String, dynamic> json) =>
      _$CreateCampaignReplyPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCampaignReplyPayloadToJson(this);
}
