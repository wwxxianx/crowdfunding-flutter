import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/organization/create_organization_payload.dart';
import 'package:crowdfunding_flutter/domain/usecases/organization/fetch_organization.dart';
import 'package:crowdfunding_flutter/domain/usecases/organization/fetch_organization_members.dart';
import 'package:crowdfunding_flutter/domain/usecases/organization/update_organization.dart';
import 'package:crowdfunding_flutter/state_management/edit_organization/edit_organization_event.dart';
import 'package:crowdfunding_flutter/state_management/edit_organization/edit_organization_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditOrganizationBloc
    extends Bloc<EditOrganizationEvent, EditOrganizationState> {
  final FetchOrganization _fetchOrganization;
  final FetchOrganizationMembers _fetchOrganizationMembers;
  final UpdateOrganization _updateOrganization;
  EditOrganizationBloc({
    required FetchOrganization fetchOrganization,
    required FetchOrganizationMembers fetchOrganizationMembers,
    required UpdateOrganization updateOrganization,
  })  : _fetchOrganization = fetchOrganization,
        _fetchOrganizationMembers = fetchOrganizationMembers,
        _updateOrganization = updateOrganization,
        super(const EditOrganizationState.initial()) {
    on<EditOrganizationEvent>(_onEvent);
  }

  Future<void> _onEvent(
      EditOrganizationEvent event, Emitter<EditOrganizationState> emit) async {
    return switch (event) {
      final OnInitOrganization e => _onInitOrganization(e, emit),
      final OnFetchOrganizationMembers e =>
        _onFetchOrganizationMembers(e, emit),
      final OnNameChanged e => emit(state.copyWith(nameText: e.value)),
      final OnEmailChanged e => emit(state.copyWith(emailText: e.value)),
      final OnPhoneNumberChanged e =>
        emit(state.copyWith(contactPhoneNumberText: e.value)),
      final OnImageFileChanged e => emit(state.copyWith(imageFile: e.file)),
      final OnUpdateOrganization e => _onUpdateOrganization(e, emit),
    };
  }

  Future<void> _onFetchOrganizationMembers(OnFetchOrganizationMembers event,
      Emitter<EditOrganizationState> emit) async {
    emit(state.copyWith(membersResult: const ApiResultLoading()));
    final res = await _fetchOrganizationMembers.call(event.organizationId);
    res.fold(
      (failure) => emit(state.copyWith(
          membersResult: ApiResultFailure(failure.errorMessage))),
      (members) =>
          emit(state.copyWith(membersResult: ApiResultSuccess(members))),
    );
  }

  Future<void> _onInitOrganization(
      OnInitOrganization event, Emitter<EditOrganizationState> emit) async {
    emit(state.copyWith(organizationResult: const ApiResultLoading()));
    if (event.organization != null) {
      emit(state.copyWith(
          organizationResult: ApiResultSuccess(event.organization!)));
      return;
    }
    // Fetch again from backend
    final res = await _fetchOrganization.call(event.organizationId);
    res.fold(
      (failure) => emit(state.copyWith(
          organizationResult: ApiResultFailure(failure.errorMessage))),
      (organization) => emit(
          state.copyWith(organizationResult: ApiResultSuccess(organization))),
    );
  }

  Future<void> _onUpdateOrganization(
    OnUpdateOrganization event,
    Emitter<EditOrganizationState> emit,
  ) async {
    emit(state.copyWith(isUpdatingOrganization: true));
    final payload = UpdateOrganizationPayload(
      npoName: state.nameText,
      npoContactPhoneNumber: state.contactPhoneNumberText,
      npoEmail: state.emailText,
      organizationId: event.organizationId,
      imageFile: state.imageFile,
    );
    final res = await _updateOrganization.call(payload);
    res.fold(
      (failure) {
        emit(state.copyWith(
          isUpdatingOrganization: false,
          updateOrganizationError: failure.errorMessage,
        ));
      },
      (organization) {
        emit(state.copyWith(
          isUpdatingOrganization: false,
          organizationResult: ApiResultSuccess(organization),
        ));
        event.onSuccess();
      },
    );
  }
}
