import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:equatable/equatable.dart';

final class OrganizationProfileState extends Equatable {
  final ApiResult<Organization> organizationResult;

  const OrganizationProfileState._({
    required this.organizationResult,
  });

  const OrganizationProfileState.initial()
      : this._(organizationResult: const ApiResultInitial());

  OrganizationProfileState copyWith({
    ApiResult<Organization>? organizationResult,
  }) {
    return OrganizationProfileState._(
      organizationResult: organizationResult ?? this.organizationResult,
    );
  }
    
  @override
  List<Object?> get props => [
        organizationResult,
      ];
}
