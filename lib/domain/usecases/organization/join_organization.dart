import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/payload/organization/join_organization_payload.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/repository/organization/organization_repository.dart';
import 'package:fpdart/src/either.dart';

class JoinOrganization
    implements UseCase<UserModel, JoinOrganizationPayload> {
  final OrganizationRepository organizationRepository;

  const JoinOrganization({required this.organizationRepository});

  @override
  Future<Either<Failure, UserModel>> call(
      JoinOrganizationPayload payload) async {
    return await organizationRepository.joinOrganization(payload);
  }
}
