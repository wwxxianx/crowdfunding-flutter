import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/usecases/community_challenge/fetch_community_challenges.dart';
import 'package:crowdfunding_flutter/state_management/community_challenge/community_challenge_event.dart';
import 'package:crowdfunding_flutter/state_management/community_challenge/community_challenge_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityChallengeBloc
    extends Bloc<CommunityChallengeEvent, CommunityChallengeState> {
  final FetchCommunityChallenges _fetchCommunityChallenges;

  CommunityChallengeBloc({
    required FetchCommunityChallenges fetchCommunityChallenges,
  })  : _fetchCommunityChallenges = fetchCommunityChallenges,
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
    };
  }

  Future<void> _onFetchCommunityChallenges(
    OnFetchCommunityChallenges event,
    Emitter<CommunityChallengeState> emit,
  ) async {
    emit(state.copyWith(communityChallengesResult: const ApiResultLoading()));

    final res = await _fetchCommunityChallenges.call(NoPayload());
    res.fold(
      (failure) => emit(state.copyWith(communityChallengesResult: ApiResultFailure(failure.errorMessage))),
      (data) => emit(state.copyWith(communityChallengesResult: ApiResultSuccess(data))),
    );
  }
}
