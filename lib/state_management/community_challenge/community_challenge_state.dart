import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/community_challenge.dart';
import 'package:equatable/equatable.dart';

final class CommunityChallengeState extends Equatable {
  final ApiResult<List<CommunityChallenge>> communityChallengesResult;

  const CommunityChallengeState._({
    this.communityChallengesResult = const ApiResultInitial(),
  });

  const CommunityChallengeState.initial() : this._();

  CommunityChallengeState copyWith({
    ApiResult<List<CommunityChallenge>>? communityChallengesResult,
  }) {
    return CommunityChallengeState._(
      communityChallengesResult:
          communityChallengesResult ?? this.communityChallengesResult,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [communityChallengesResult];
}
