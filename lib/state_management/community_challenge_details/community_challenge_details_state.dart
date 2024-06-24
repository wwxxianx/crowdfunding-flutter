import 'dart:io';

import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/challenge_participant.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/community_challenge.dart';
import 'package:equatable/equatable.dart';

final class CommunityChallengeDetailsState extends Equatable {
  final ApiResult<CommunityChallenge> communityChallengeResult;
  final ApiResult<ChallengeParticipant> challengeProgressResult;
  final ApiResult<ChallengeParticipant> participateResult;
  final ApiResult<ChallengeParticipant> updateProgressResult;
  final bool isChallengeNotStarted;
  final File? selectedChallengeImageFile;

  const CommunityChallengeDetailsState._({
    this.communityChallengeResult = const ApiResultInitial(),
    this.challengeProgressResult = const ApiResultInitial(),
    this.participateResult = const ApiResultInitial(),
    this.updateProgressResult = const ApiResultInitial(),
    this.isChallengeNotStarted = true,
    this.selectedChallengeImageFile,
  });

  const CommunityChallengeDetailsState.initial() : this._();

  CommunityChallengeDetailsState copyWith({
    ApiResult<CommunityChallenge>? communityChallengeResult,
    ApiResult<ChallengeParticipant>? challengeProgressResult,
    ApiResult<ChallengeParticipant>? participateResult,
    ApiResult<ChallengeParticipant>? updateProgressResult,
    bool? isChallengeNotStarted,
    File? selectedChallengeImageFile,
  }) {
    return CommunityChallengeDetailsState._(
      communityChallengeResult:
          communityChallengeResult ?? this.communityChallengeResult,
      challengeProgressResult:
          challengeProgressResult ?? this.challengeProgressResult,
      isChallengeNotStarted:
          isChallengeNotStarted ?? this.isChallengeNotStarted,
      participateResult: participateResult ?? this.participateResult,
      selectedChallengeImageFile:
          selectedChallengeImageFile ?? this.selectedChallengeImageFile,
      updateProgressResult:
          updateProgressResult ?? this.updateProgressResult,
    );
  }

  @override
  List<Object?> get props => [
        communityChallengeResult,
        challengeProgressResult,
        isChallengeNotStarted,
        participateResult,
        selectedChallengeImageFile,
        updateProgressResult,
      ];
}
