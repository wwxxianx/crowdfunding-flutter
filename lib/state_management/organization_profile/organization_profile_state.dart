import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/response/payment/connect_account_response.dart';
import 'package:crowdfunding_flutter/domain/model/collaboration/collaboration.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:equatable/equatable.dart';

final class OrganizationProfileState extends Equatable {
  final ApiResult<Organization> organizationResult;
  final ApiResult<ConnectAccountResponse> connectBankAccountResult;
  final ApiResult<List<Collaboration>> collaborationsResult;

  const OrganizationProfileState._({
    required this.organizationResult,
    required this.connectBankAccountResult,
    required this.collaborationsResult,
  });

  const OrganizationProfileState.initial()
      : this._(
          organizationResult: const ApiResultInitial(),
          connectBankAccountResult: const ApiResultInitial(),
          collaborationsResult: const ApiResultInitial(),
        );

  OrganizationProfileState copyWith({
    ApiResult<Organization>? organizationResult,
    ApiResult<ConnectAccountResponse>? connectBankAccountResult,
    ApiResult<List<Collaboration>>? collaborationsResult,
  }) {
    return OrganizationProfileState._(
      organizationResult: organizationResult ?? this.organizationResult,
      connectBankAccountResult:
          connectBankAccountResult ?? this.connectBankAccountResult,
      collaborationsResult: collaborationsResult ?? this.collaborationsResult,

    );
  }

  @override
  List<Object?> get props => [
        organizationResult,
        connectBankAccountResult,
        collaborationsResult,
      ];
}
