import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/challenge_participant.dart';
import 'package:crowdfunding_flutter/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchParticipatedChallenges
    implements UseCase<List<ChallengeParticipant>, NoPayload> {
  final UserRepository userRepository;

  const FetchParticipatedChallenges({required this.userRepository});
  @override
  Future<Either<Failure, List<ChallengeParticipant>>> call(
      NoPayload payload) async {
    return await userRepository.getParticipatedChallenges();
  }
}
