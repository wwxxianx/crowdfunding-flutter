import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:equatable/equatable.dart';

final class JoinNPOState extends Equatable {
  final String? invitationCodeText;
  final ApiResult<Organization> searchOrganizationResult;
  final ApiResult<UserModel> joinOrganizationResult;

  const JoinNPOState._({
    this.invitationCodeText,
    this.searchOrganizationResult = const ApiResultInitial(),
    this.joinOrganizationResult = const ApiResultInitial(),
  });

  const JoinNPOState.initial() : this._();

  JoinNPOState copyWith({
    String? invitationCodeText,
    ApiResult<Organization>? searchOrganizationResult,
    ApiResult<UserModel>? joinOrganizationResult,
  }) {
    return JoinNPOState._(
      invitationCodeText: invitationCodeText ?? this.invitationCodeText,
      searchOrganizationResult:
          searchOrganizationResult ?? this.searchOrganizationResult,
      joinOrganizationResult:
          joinOrganizationResult ?? this.joinOrganizationResult,
    );
  }

  @override
  List<Object?> get props => [
        invitationCodeText,
        searchOrganizationResult,
        joinOrganizationResult,
      ];
}
