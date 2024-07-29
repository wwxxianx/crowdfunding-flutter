import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/collaboration/fetch_collaboration_filter.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/domain/usecases/collaboration/fetch_collaborations.dart';
import 'package:crowdfunding_flutter/domain/usecases/organization/fetch_organization.dart';
import 'package:crowdfunding_flutter/domain/usecases/stripe/connect_organization_bank_account.dart';
import 'package:crowdfunding_flutter/state_management/organization_profile/organization_profile_event.dart';
import 'package:crowdfunding_flutter/state_management/organization_profile/organization_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrganizationProfileBloc
    extends Bloc<OrganizationProfileEvent, OrganizationProfileState> {
  final FetchOrganization _fetchOrganization;
  final ConnectOrganizationBankAccount _connectOrganizationBankAccount;
  final FetchCollaborations _fetchCollaborations;
  OrganizationProfileBloc({
    required FetchOrganization fetchOrganization,
    required ConnectOrganizationBankAccount connectOrganizationBankAccount,
    required FetchCollaborations fetchCollaborations,
  })  : _fetchOrganization = fetchOrganization,
        _connectOrganizationBankAccount = connectOrganizationBankAccount,
        _fetchCollaborations = fetchCollaborations,
        super(const OrganizationProfileState.initial()) {
    on<OrganizationProfileEvent>(_onEvent);
  }

  Future<void> _onEvent(OrganizationProfileEvent event,
      Emitter<OrganizationProfileState> emit) async {
    return switch (event) {
      final OnFetchOrganization e => _onFetchOrganization(e, emit),
      final OnConnectOrganizationBankAccount e =>
        _onConnectOrganizationBankAccount(e, emit),
      final OnFetchOrganizationCollaborations e =>
        _onFetchOrganizationCollaborations(e, emit),
    };
  }

  Future<void> _onFetchOrganizationCollaborations(
      OnFetchOrganizationCollaborations event,
      Emitter<OrganizationProfileState> emit) async {
    emit(state.copyWith(collaborationsResult: const ApiResultLoading()));
    final organizationResult = state.organizationResult;
    if (organizationResult is! ApiResultSuccess<Organization>) {
      return;
    }
    final filter =
        FetchCollaborationFilter(organizationId: organizationResult.data.id);
    final res = await _fetchCollaborations.call(filter);
    res.fold(
      (failure) => emit(state.copyWith(
          collaborationsResult: ApiResultFailure(failure.errorMessage))),
      (collaborations) => emit(state.copyWith(
          collaborationsResult: ApiResultSuccess(collaborations))),
    );
  }

  Future<void> _onConnectOrganizationBankAccount(
      OnConnectOrganizationBankAccount event,
      Emitter<OrganizationProfileState> emit) async {
    emit(state.copyWith(connectBankAccountResult: const ApiResultLoading()));
    final res = await _connectOrganizationBankAccount.call(NoPayload());
    res.fold(
      (failure) => emit(state.copyWith(
          connectBankAccountResult: ApiResultFailure(failure.errorMessage))),
      (response) {
        emit(state.copyWith(
            connectBankAccountResult: ApiResultSuccess(response)));
        event.onSuccess(response.onboardLink);
      },
    );
  }

  Future<void> _onFetchOrganization(
      OnFetchOrganization event, Emitter<OrganizationProfileState> emit) async {
    // emit(state.copyWith(
    //     organizationResult: ApiResultSuccess(Organization.samples.first)));
    emit(state.copyWith(organizationResult: const ApiResultLoading()));
    final res = await _fetchOrganization.call(event.organizationId);
    res.fold(
      (failure) {
        // _isOrganizationFetched = false;
        emit(state.copyWith(
            organizationResult: ApiResultFailure(failure.errorMessage)));
      },
      (organization) {
        // _isOrganizationFetched = true;
        emit(
            state.copyWith(organizationResult: ApiResultSuccess(organization)));
      },
    );
    await _onFetchOrganizationCollaborations(
        OnFetchOrganizationCollaborations(organizationId: event.organizationId),
        emit);
  }
}
