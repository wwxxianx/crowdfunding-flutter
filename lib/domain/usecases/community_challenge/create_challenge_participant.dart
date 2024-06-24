import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/payload/community_challenge/create_challenge_participant_payload.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/challenge_participant.dart';
import 'package:crowdfunding_flutter/domain/repository/community_challenge/community_challenge_repository.dart';
import 'package:fpdart/src/either.dart';

class CreateChallengeParticipant
    implements
        UseCase<ChallengeParticipant, CreateChallengeParticipantPayload> {
  final CommunityChallengeRepository communityChallengeRepository;

  const CreateChallengeParticipant(
      {required this.communityChallengeRepository});

  @override
  Future<Either<Failure, ChallengeParticipant>> call(
      CreateChallengeParticipantPayload payload) async {
    return await communityChallengeRepository
        .createChallengeParticipant(payload);
  }
}
