import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/data/network/payload/community_challenge/create_challenge_participant_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/community_challenge/update_challenge_participant_payload.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/challenge_participant.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/community_challenge.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CommunityChallengeRepository {
  Future<Either<Failure, List<CommunityChallenge>>> getCommunityChallenges();
  Future<Either<Failure, CommunityChallenge>> getCommunityChallenge(String id);
  Future<Either<Failure, ChallengeParticipant?>> getChallengeProgress(
      {required String communityChallengeId});
  Future<Either<Failure, ChallengeParticipant>> createChallengeParticipant(
      CreateChallengeParticipantPayload payload);
  Future<Either<Failure, ChallengeParticipant>> updateChallengeParticipant(
      UpdateChallengeParticipantPayload payload);
}
