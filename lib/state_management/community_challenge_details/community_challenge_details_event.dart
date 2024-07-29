import 'dart:io';

sealed class CommunityChallengeDetailsEvent {
  const CommunityChallengeDetailsEvent();
}

final class OnFetchCommunityChallenge extends CommunityChallengeDetailsEvent {
  final String id;

  const OnFetchCommunityChallenge({required this.id});
}

final class OnFetchChallengeProgress extends CommunityChallengeDetailsEvent {
  final String communityChallengeId;

  const OnFetchChallengeProgress({
    required this.communityChallengeId,
  });
}

final class OnRefreshChallengeProgress extends CommunityChallengeDetailsEvent {
  final String communityChallengeId;

  const OnRefreshChallengeProgress({
    required this.communityChallengeId,
  });
}

final class OnParticipateChallenge extends CommunityChallengeDetailsEvent {
  final String communityChallengeId;

  const OnParticipateChallenge({required this.communityChallengeId});
}

final class OnChallengeImageFileChanged extends CommunityChallengeDetailsEvent {
  final File imageFile;

  const OnChallengeImageFileChanged({required this.imageFile});
}

final class OnUpdateChallengeProgress extends CommunityChallengeDetailsEvent {
  final String communityChallengeId;

  const OnUpdateChallengeProgress({required this.communityChallengeId});
}
