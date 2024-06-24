import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/community_challenge.dart';
import 'package:crowdfunding_flutter/domain/repository/community_challenge/community_challenge_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchCommunityChallenge
    implements UseCase<CommunityChallenge, String> {
  final CommunityChallengeRepository communityChallengeRepository;

  const FetchCommunityChallenge({required this.communityChallengeRepository});

  @override
  Future<Either<Failure, CommunityChallenge>> call(
      String payload) async {
    return await communityChallengeRepository.getCommunityChallenge(payload);
  }
}
