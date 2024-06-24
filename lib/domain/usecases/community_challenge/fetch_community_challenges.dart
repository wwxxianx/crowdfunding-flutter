import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/community_challenge.dart';
import 'package:crowdfunding_flutter/domain/repository/community_challenge/community_challenge_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchCommunityChallenges
    implements UseCase<List<CommunityChallenge>, NoPayload> {
  final CommunityChallengeRepository communityChallengeRepository;

  const FetchCommunityChallenges({required this.communityChallengeRepository});

  @override
  Future<Either<Failure, List<CommunityChallenge>>> call(
      NoPayload payload) async {
    return await communityChallengeRepository.getCommunityChallenges();
  }
}
