import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/payload/organization/create_organization_payload.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/domain/repository/organization/organization_repository.dart';
import 'package:fpdart/src/either.dart';

class UpdateOrganization
    implements UseCase<Organization, UpdateOrganizationPayload> {
  final OrganizationRepository organizationRepository;

  const UpdateOrganization({required this.organizationRepository});
  @override
  Future<Either<Failure, Organization>> call(
      UpdateOrganizationPayload payload) async {
    return await organizationRepository.updateOrganization(payload);
  }
}
