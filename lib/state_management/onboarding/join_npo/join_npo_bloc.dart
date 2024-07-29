import 'package:crowdfunding_flutter/common/utils/input_validator.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/organization/join_organization_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/user_profile_payload.dart';
import 'package:crowdfunding_flutter/domain/usecases/organization/fetch_organization_with_code.dart';
import 'package:crowdfunding_flutter/domain/usecases/organization/join_organization.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/update_user_profile.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/join_npo/join_npo_event.dart';
import 'package:crowdfunding_flutter/state_management/onboarding/join_npo/join_npo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JoinNPOBloc extends Bloc<JoinNPOEvent, JoinNPOState> with InputValidator {
  final FetchOrganizationWithCode _fetchOrganizationWithCode;
  final JoinOrganization _joinOrganization;
  final UpdateUserProfile _updateUserProfile;
  JoinNPOBloc({
    required FetchOrganizationWithCode fetchOrganizationWithCode,
    required JoinOrganization joinOrganization,
    required UpdateUserProfile updateUserProfile,
  })  : _fetchOrganizationWithCode = fetchOrganizationWithCode,
        _joinOrganization = joinOrganization,
        _updateUserProfile = updateUserProfile,
        super(const JoinNPOState.initial()) {
    on<JoinNPOEvent>(_onEvent);
  }

  Future<void> _onEvent(
    JoinNPOEvent event,
    Emitter<JoinNPOState> emit,
  ) async {
    return switch (event) {
      final OnCodeTextChanged e => _onCodeTextChanged(e, emit),
      final OnFetchOrganization e => _onFetchOrganization(e, emit),
      final OnJoinOrganization e => _onJoinOrganization(e, emit),
      final OnboardCompleteWithoutJoinNPO e =>
        _onboardCompleteWithoutJoinNPO(e, emit),
    };
  }

  Future<void> _onboardCompleteWithoutJoinNPO(
    OnboardCompleteWithoutJoinNPO event,
    Emitter<JoinNPOState> emit,
  ) async {
    emit(state.copyWith(joinOrganizationResult: const ApiResultLoading()));
    final payload = UserProfilePayload(isOnBoardingCompleted: true);
    final res = await _updateUserProfile(payload);
    res.fold(
      (failure) {
        emit(state.copyWith(
            joinOrganizationResult: ApiResultFailure(failure.errorMessage)));
      },
      (userModel) {
        emit(state.copyWith(
            joinOrganizationResult: ApiResultSuccess(userModel)));
        event.onSuccess();
      },
    );
  }

  Future<void> _onJoinOrganization(
    OnJoinOrganization event,
    Emitter<JoinNPOState> emit,
  ) async {
    emit(state.copyWith(joinOrganizationResult: const ApiResultLoading()));
    final payload =
        JoinOrganizationPayload(organizationId: event.organizationId);
    final res = await _joinOrganization.call(payload);
    res.fold(
      (l) => emit(state.copyWith(
            joinOrganizationResult: ApiResultFailure(l.errorMessage))),
      (userModel) {
        emit(state.copyWith(
            joinOrganizationResult: ApiResultSuccess(userModel)));
        event.onSuccess();
      },
    );
  }

  Future<void> _onFetchOrganization(
    OnFetchOrganization event,
    Emitter<JoinNPOState> emit,
  ) async {
    emit(state.copyWith(searchOrganizationResult: const ApiResultLoading()));
    // validate code against format
    final codeResult = validateInvitationCode(state.invitationCodeText);
    if (!codeResult.successful) {
      emit(state.copyWith(
          searchOrganizationResult: ApiResultFailure(codeResult.errorMessage)));
      return;
    }
    final res =
        await _fetchOrganizationWithCode.call(state.invitationCodeText!);
    res.fold(
      (l) => emit(state.copyWith(searchOrganizationResult: ApiResultFailure(l.errorMessage))),
      (organization) {
        emit(state.copyWith(
            searchOrganizationResult: ApiResultSuccess(organization)));
        event.onSuccess();
      },
    );
  }

  void _onCodeTextChanged(
    OnCodeTextChanged event,
    Emitter<JoinNPOState> emit,
  ) {
    emit(state.copyWith(invitationCodeText: event.value));
  }
}
