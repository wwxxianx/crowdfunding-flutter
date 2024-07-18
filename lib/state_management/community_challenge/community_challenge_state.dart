import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/challenge_participant.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/community_challenge.dart';
import 'package:equatable/equatable.dart';

final class CommunityChallengeState extends Equatable {
  final ApiResult<List<CommunityChallenge>> communityChallengesResult;
  final ApiResult<List<ChallengeParticipant>> participatedChallenges;

  const CommunityChallengeState._({
    this.communityChallengesResult = const ApiResultInitial(),
    this.participatedChallenges = const ApiResultInitial(),
  });

  const CommunityChallengeState.initial() : this._();

  CommunityChallengeState copyWith({
    ApiResult<List<CommunityChallenge>>? communityChallengesResult,
    ApiResult<List<ChallengeParticipant>>? participatedChallenges,
  }) {
    return CommunityChallengeState._(
      communityChallengesResult:
          communityChallengesResult ?? this.communityChallengesResult,
      participatedChallenges:
          participatedChallenges ?? this.participatedChallenges,
    );
  }

  @override 
  List<Object?> get props => [communityChallengesResult, participatedChallenges];
}
