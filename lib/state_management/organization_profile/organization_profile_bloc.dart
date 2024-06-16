import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/domain/usecases/organization/fetch_organization.dart';
import 'package:crowdfunding_flutter/state_management/organization_profile/organization_profile_event.dart';
import 'package:crowdfunding_flutter/state_management/organization_profile/organization_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrganizationProfileBloc
    extends Bloc<OrganizationProfileEvent, OrganizationProfileState> {
  final FetchOrganization _fetchOrganization;
  OrganizationProfileBloc({
    required FetchOrganization fetchOrganization,
  })  : _fetchOrganization = fetchOrganization,
        super(const OrganizationProfileState.initial()) {
    on<OrganizationProfileEvent>(_onEvent);
  }

  Future<void> _onEvent(OrganizationProfileEvent event,
      Emitter<OrganizationProfileState> emit) async {
    return switch (event) {
      final OnFetchOrganization e => _onFetchOrganization(e, emit),
    };
  }

  Future<void> _onFetchOrganization(
      OnFetchOrganization event, Emitter<OrganizationProfileState> emit) async {
    emit(state.copyWith(
        organizationResult: ApiResultSuccess(Organization.samples.first)));
    // emit(state.copyWith(organizationResult: const ApiResultLoading()));
    // final res = await _fetchOrganization.call(event.organizationId);
    // res.fold(
    //   (failure) => emit(state.copyWith(
    //       organizationResult: ApiResultFailure(failure.errorMessage))),
    //   (organization) => emit(
    //       state.copyWith(organizationResult: ApiResultSuccess(organization))),
    // );
  }
}
