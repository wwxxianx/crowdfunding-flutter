import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/data/network/payload/organization/create_organization_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/organization/get_organizations_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/organization/join_organization_payload.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class OrganizationRepository {
  Future<Either<Failure, Organization>> getOrganization(
    String organizationId,
  );

Future<Either<Failure, List<Organization>>> getOrganizations(
    GetOrganizationsPayload payload,
  );

  Future<Either<Failure, UserModel>> createOrganization(
    CreateOrganizationPayload payload,
  );

  Future<Either<Failure, Organization>> updateOrganization(
    UpdateOrganizationPayload payload,
  );

  Future<Either<Failure, Organization>> getOrganizationByInvitationCode(
    String invitationCode,
  );

  Future<Either<Failure, List<UserModel>>> getOrganizationMembers(
    String organizationId,
  );
  
  Future<Either<Failure, UserModel>> joinOrganization(
    JoinOrganizationPayload payload,
  );
}
