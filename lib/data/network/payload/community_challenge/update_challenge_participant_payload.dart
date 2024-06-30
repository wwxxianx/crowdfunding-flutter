import 'dart:io';

class UpdateChallengeParticipantPayload {
  final String communityChallengeId;
  final File? imageFile;

  const UpdateChallengeParticipantPayload({
    required this.communityChallengeId,
    this.imageFile,
  });
}
