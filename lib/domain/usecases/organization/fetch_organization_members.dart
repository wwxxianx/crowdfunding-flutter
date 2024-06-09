import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/repository/organization/organization_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchOrganizationMembers implements UseCase<List<UserModel>, String> {
  final OrganizationRepository organizationRepository;

  const FetchOrganizationMembers({required this.organizationRepository});
  @override
  Future<Either<Failure, List<UserModel>>> call(String payload) async {
    return await organizationRepository.getOrganizationMembers(payload);
  }
}
