import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/payload/community_challenge/update_challenge_participant_payload.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/challenge_participant.dart';
import 'package:crowdfunding_flutter/domain/repository/community_challenge/community_challenge_repository.dart';
import 'package:fpdart/src/either.dart';

class UpdateChallengeParticipant
    implements
        UseCase<ChallengeParticipant, UpdateChallengeParticipantPayload> {
  final CommunityChallengeRepository communityChallengeRepository;

  const UpdateChallengeParticipant(
      {required this.communityChallengeRepository});

  @override
  Future<Either<Failure, ChallengeParticipant>> call(
      UpdateChallengeParticipantPayload payload) async {
    return await communityChallengeRepository
        .updateChallengeParticipant(payload);
  }
}
