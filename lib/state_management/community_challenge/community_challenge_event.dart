sealed class CommunityChallengeEvent {
  const CommunityChallengeEvent();
}

final class OnFetchCommunityChallenges extends CommunityChallengeEvent {}

final class OnFetchParticipatedChallenges extends CommunityChallengeEvent {}