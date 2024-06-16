import 'package:json_annotation/json_annotation.dart';

part 'create_collaboration_payload.g.dart';

@JsonSerializable()
class CreateCollaborationPayload {
  final double reward;
  final String campaignId;

  const CreateCollaborationPayload({
    required this.reward, required this.campaignId,
  });

  factory CreateCollaborationPayload.fromJson(Map<String, dynamic> json) => _$CreateCollaborationPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCollaborationPayloadToJson(this);
}
