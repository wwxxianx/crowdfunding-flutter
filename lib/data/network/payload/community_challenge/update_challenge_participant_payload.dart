import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

class UpdateChallengeParticipantPayload {
  final String communityChallengeId;
  final File? imageFile;

  const UpdateChallengeParticipantPayload({
    required this.communityChallengeId,
    this.imageFile,
  });
}
