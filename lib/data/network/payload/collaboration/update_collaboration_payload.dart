import 'package:json_annotation/json_annotation.dart';

part 'update_collaboration_payload.g.dart';

@JsonSerializable()
class UpdateCollaborationPayload {
  final String collaborationId;
  final String? organizationId;
  final double? reward;

  const UpdateCollaborationPayload({
    required this.collaborationId,
    this.organizationId,
    this.reward,
  });

  factory UpdateCollaborationPayload.fromJson(Map<String, dynamic> json) =>
      _$UpdateCollaborationPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCollaborationPayloadToJson(this);
}
