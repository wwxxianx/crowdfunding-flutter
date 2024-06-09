import 'package:json_annotation/json_annotation.dart';

part 'join_organization_payload.g.dart';

@JsonSerializable()
class JoinOrganizationPayload {
  final String organizationId;

  const JoinOrganizationPayload({
    required this.organizationId,
  });

  factory JoinOrganizationPayload.fromJson(Map<String, dynamic> json) => _$JoinOrganizationPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$JoinOrganizationPayloadToJson(this);
}