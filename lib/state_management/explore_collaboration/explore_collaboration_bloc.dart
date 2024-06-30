import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/usecases/collaboration/fetch_pending_collaborations.dart';
import 'package:crowdfunding_flutter/state_management/explore_collaboration/explore_collaboration_event.dart';
import 'package:crowdfunding_flutter/state_management/explore_collaboration/explore_collaboration_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreCollaborationBloc
    extends Bloc<ExploreCollaborationEvent, ExploreCollaborationState> {
  final FetchPendingCollaborations _fetchPendingCollaborations;

  ExploreCollaborationBloc({
    required FetchPendingCollaborations fetchPendingCollaborations,
  })  : _fetchPendingCollaborations = fetchPendingCollaborations,
        super(const ExploreCollaborationState.initial()) {
    on<ExploreCollaborationEvent>(_onEvent);
  }

  Future<void> _onEvent(
    ExploreCollaborationEvent event,
    Emitter<ExploreCollaborationState> emit,
  ) async {
    return switch (event) {
      final OnFetchPendingCollaborations e =>
        _onFetchPendingCollaborations(e, emit),
      final OnTakeCollaboration e =>
        _onTakeCollaboration(e, emit),
    };
  }

  Future<void> _onTakeCollaboration(
    OnTakeCollaboration event,
    Emitter<ExploreCollaborationState> emit,
  ) async {
    
  }

  Future<void> _onFetchPendingCollaborations(
    OnFetchPendingCollaborations event,
    Emitter<ExploreCollaborationState> emit,
  ) async {
    // emit(state.copyWith(collaborationsResult: ApiResultSuccess(Collaboration.samples)));
    emit(state.copyWith(collaborationsResult: const ApiResultLoading()));

    final res = await _fetchPendingCollaborations.call(NoPayload());
    res.fold(
      (failure) {
        emit(state.copyWith(
            collaborationsResult: ApiResultFailure(failure.errorMessage)));
      },
      (collaborations) {
        emit(state.copyWith(
            collaborationsResult: ApiResultSuccess(collaborations)));
      },
    );
  }
}
