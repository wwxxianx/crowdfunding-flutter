import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/domain/repository/organization/organization_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchOrganizationWithCode implements UseCase<Organization, String> {
  final OrganizationRepository organizationRepository;

  const FetchOrganizationWithCode({required this.organizationRepository});
  @override
  Future<Either<Failure, Organization>> call(String payload) async {
    return await organizationRepository
        .getOrganizationByInvitationCode(payload);
  }
}
