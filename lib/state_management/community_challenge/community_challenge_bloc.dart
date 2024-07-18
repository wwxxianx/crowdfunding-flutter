import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/usecases/community_challenge/fetch_community_challenges.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/community_challenge/fetch_participated_challenges.dart';
import 'package:crowdfunding_flutter/state_management/community_challenge/community_challenge_event.dart';
import 'package:crowdfunding_flutter/state_management/community_challenge/community_challenge_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityChallengeBloc
    extends Bloc<CommunityChallengeEvent, CommunityChallengeState> {
  final FetchCommunityChallenges _fetchCommunityChallenges;
  final FetchParticipatedChallenges _fetchParticipatedChallenges;

  CommunityChallengeBloc({
    required FetchCommunityChallenges fetchCommunityChallenges,
    required FetchParticipatedChallenges fetchParticipatedChallenges,
  })  : _fetchCommunityChallenges = fetchCommunityChallenges,
        _fetchParticipatedChallenges = fetchParticipatedChallenges,
        super(const CommunityChallengeState.initial()) {
    on<CommunityChallengeEvent>(_onEvent);
  }

  Future<void> _onEvent(
    CommunityChallengeEvent event,
    Emitter<CommunityChallengeState> emit,
  ) async {
    return switch (event) {
      final OnFetchCommunityChallenges e =>
        _onFetchCommunityChallenges(e, emit),
      final OnFetchParticipatedChallenges e =>
        _onFetchParticipatedChallenges(e, emit),
    };
  }

  Future<void> _onFetchParticipatedChallenges(
    OnFetchParticipatedChallenges event,
    Emitter<CommunityChallengeState> emit,
  ) async {
    emit(state.copyWith(participatedChallenges: const ApiResultLoading()));

    final res = await _fetchParticipatedChallenges.call(NoPayload());
    res.fold(
      (failure) => emit(state.copyWith(
          participatedChallenges: ApiResultFailure(failure.errorMessage))),
      (data) => emit(
          state.copyWith(participatedChallenges: ApiResultSuccess(data))),
    );
  }

  Future<void> _onFetchCommunityChallenges(
    OnFetchCommunityChallenges event,
    Emitter<CommunityChallengeState> emit,
  ) async {
    emit(state.copyWith(communityChallengesResult: const ApiResultLoading()));

    final res = await _fetchCommunityChallenges.call(NoPayload());
    res.fold(
      (failure) => emit(state.copyWith(
          communityChallengesResult: ApiResultFailure(failure.errorMessage))),
      (data) => emit(
          state.copyWith(communityChallengesResult: ApiResultSuccess(data))),
    );
  }
}
