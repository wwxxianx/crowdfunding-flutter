import 'package:json_annotation/json_annotation.dart';

part 'create_challenge_participant_payload.g.dart';

@JsonSerializable()
class CreateChallengeParticipantPayload {
  final String communityChallengeId;

  const CreateChallengeParticipantPayload({
    required this.communityChallengeId,
  });

  factory CreateChallengeParticipantPayload.fromJson(Map<String, dynamic> json) => _$CreateChallengeParticipantPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$CreateChallengeParticipantPayloadToJson(this);
}