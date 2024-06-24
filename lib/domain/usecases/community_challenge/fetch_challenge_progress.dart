import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/challenge_participant.dart';
import 'package:crowdfunding_flutter/domain/repository/community_challenge/community_challenge_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchChallengeProgress implements UseCase<ChallengeParticipant?, String> {
  final CommunityChallengeRepository communityChallengeRepository;

  const FetchChallengeProgress({required this.communityChallengeRepository});

  @override
  Future<Either<Failure, ChallengeParticipant?>> call(String payload) async {
    return await communityChallengeRepository.getChallengeProgress(communityChallengeId: payload);
  }
}
