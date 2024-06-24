import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/community_challenge/create_challenge_participant_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/community_challenge/update_challenge_participant_payload.dart';
import 'package:crowdfunding_flutter/domain/usecases/community_challenge/create_challenge_participant.dart';
import 'package:crowdfunding_flutter/domain/usecases/community_challenge/fetch_challenge_progress.dart';
import 'package:crowdfunding_flutter/domain/usecases/community_challenge/fetch_community_challenge.dart';
import 'package:crowdfunding_flutter/domain/usecases/community_challenge/update_challenge_participant.dart';
import 'package:crowdfunding_flutter/state_management/community_challenge_details/community_challenge_details_event.dart';
import 'package:crowdfunding_flutter/state_management/community_challenge_details/community_challenge_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityChallengeDetailsBloc extends Bloc<CommunityChallengeDetailsEvent,
    CommunityChallengeDetailsState> {
  final FetchCommunityChallenge _fetchCommunityChallenge;
  final FetchChallengeProgress _fetchChallengeProgress;
  final CreateChallengeParticipant _createChallengeParticipant;
  final UpdateChallengeParticipant _updateChallengeParticipant;

  CommunityChallengeDetailsBloc({
    required FetchCommunityChallenge fetchCommunityChallenge,
    required FetchChallengeProgress fetchChallengeProgress,
    required CreateChallengeParticipant createChallengeParticipant,
    required UpdateChallengeParticipant updateChallengeParticipant,
  })  : _fetchCommunityChallenge = fetchCommunityChallenge,
        _fetchChallengeProgress = fetchChallengeProgress,
        _createChallengeParticipant = createChallengeParticipant,
        _updateChallengeParticipant = updateChallengeParticipant,
        super(const CommunityChallengeDetailsState.initial()) {
    on<CommunityChallengeDetailsEvent>(_onEvent);
  }

  Future<void> _onEvent(
    CommunityChallengeDetailsEvent event,
    Emitter<CommunityChallengeDetailsState> emit,
  ) async {
    return switch (event) {
      final OnFetchCommunityChallenge e => _onFetchCommunityChallenge(e, emit),
      final OnFetchChallengeProgress e => _onFetchChallengeProgress(e, emit),
      final OnParticipateChallenge e => _onParticipateChallenge(e, emit),
      final OnChallengeImageFileChanged e =>
        _onChallengeImageFileChanged(e, emit),
      final OnUpdateChallengeProgress e => _onUpdateChallengeProgress(e, emit),
    };
  }

  Future<void> _onUpdateChallengeProgress(
    OnUpdateChallengeProgress event,
    Emitter<CommunityChallengeDetailsState> emit,
  ) async {
    emit(state.copyWith(updateProgressResult: const ApiResultLoading()));
    final payload = UpdateChallengeParticipantPayload(
      communityChallengeId: event.communityChallengeId,
      imageFile: state.selectedChallengeImageFile,
    );
    final res = await _updateChallengeParticipant.call(payload);
    res.fold(
      (failure) {
        emit(state.copyWith(
            updateProgressResult: ApiResultFailure(failure.errorMessage)));
      },
      (newProgress) {
        emit(state.copyWith(
          updateProgressResult: const ApiResultInitial(),
          challengeProgressResult: ApiResultSuccess(newProgress),
        ));
      },
    );
  }

  void _onChallengeImageFileChanged(
    OnChallengeImageFileChanged event,
    Emitter<CommunityChallengeDetailsState> emit,
  ) {
    emit(state.copyWith(selectedChallengeImageFile: event.imageFile));
  }

  Future<void> _onParticipateChallenge(
    OnParticipateChallenge event,
    Emitter<CommunityChallengeDetailsState> emit,
  ) async {
    emit(state.copyWith(participateResult: const ApiResultLoading()));
    final payload = CreateChallengeParticipantPayload(
        communityChallengeId: event.communityChallengeId);
    final res = await _createChallengeParticipant.call(payload);
    res.fold(
      (failure) {
        emit(state.copyWith(
            participateResult: ApiResultFailure(failure.errorMessage)));
      },
      (challengeProgress) {
        emit(state.copyWith(
          challengeProgressResult: ApiResultSuccess(challengeProgress),
          participateResult: const ApiResultInitial(),
        ));
      },
    );
  }

  Future<void> _onFetchChallengeProgress(
    OnFetchChallengeProgress event,
    Emitter<CommunityChallengeDetailsState> emit,
  ) async {
    emit(state.copyWith(challengeProgressResult: const ApiResultLoading()));
    // emit(state.copyWith(
    //   challengeProgressResult:
    //       ApiResultSuccess(ChallengeParticipant.samples[0]),
    //   isChallengeNotStarted: false,
    // ));
    final res = await _fetchChallengeProgress.call(event.communityChallengeId);
    res.fold(
      (failure) => emit(state.copyWith(
          communityChallengeResult: ApiResultFailure(failure.errorMessage))),
      (data) {
        if (data == null) {
          // Not started the challenge
          emit(
            state.copyWith(
              challengeProgressResult: const ApiResultInitial(),
              isChallengeNotStarted: true,
            ),
          );
        }
        emit(
          state.copyWith(
              challengeProgressResult: ApiResultSuccess(data!),
              isChallengeNotStarted: false),
        );
      },
    );
  }

  Future<void> _onFetchCommunityChallenge(
    OnFetchCommunityChallenge event,
    Emitter<CommunityChallengeDetailsState> emit,
  ) async {
    emit(state.copyWith(communityChallengeResult: const ApiResultLoading()));
    // emit(state.copyWith(
    //     communityChallengeResult:
    //         ApiResultSuccess(CommunityChallenge.samples[0])));
    final res = await _fetchCommunityChallenge.call(event.id);
    res.fold(
      (failure) => emit(state.copyWith(
          communityChallengeResult: ApiResultFailure(failure.errorMessage))),
      (data) => emit(
          state.copyWith(communityChallengeResult: ApiResultSuccess(data))),
    );
  }
}
