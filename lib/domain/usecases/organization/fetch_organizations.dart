import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/payload/organization/get_organizations_payload.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/domain/repository/organization/organization_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchOrganizations
    implements UseCase<List<Organization>, GetOrganizationsPayload> {
  final OrganizationRepository organizationRepository;

  const FetchOrganizations({required this.organizationRepository});
  @override
  Future<Either<Failure, List<Organization>>> call(
      GetOrganizationsPayload payload) async {
    return await organizationRepository.getOrganizations(payload);
  }
}
