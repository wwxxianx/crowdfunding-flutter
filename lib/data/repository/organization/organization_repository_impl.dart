import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/organization/create_organization_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/organization/get_organizations_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/organization/join_organization_payload.dart';
import 'package:crowdfunding_flutter/data/network/retrofit_api.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/repository/organization/organization_repository.dart';
import 'package:crowdfunding_flutter/domain/service/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/src/either.dart';

class OrganizationRepositoryImpl implements OrganizationRepository {
  final RestClient api;
  final AuthService authService;

  const OrganizationRepositoryImpl({
    required this.api,
    required this.authService,
  });

  @override
  Future<Either<Failure, UserModel>> createOrganization(
      CreateOrganizationPayload payload) async {
    try {
      final res = await api.createOrganization(
        // registrationNumber: payload.registrationNumber,
        npoName: payload.npoName,
        npoEmail: payload.npoEmail,
        npoContactPhoneNumber: payload.npoContactPhoneNumber,
        imageFile: payload.imageFile,
      );
      await authService.updateCacheUser(user: res);
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException().errorMessage));
    }
  }

  @override
  Future<Either<Failure, Organization>> getOrganizationByInvitationCode(
      String invitationCode) async {
    try {
      final res = await api.getOrganizationByInvitationCode(
          invitationCode: invitationCode);
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException().errorMessage));
    }
  }

  @override
  Future<Either<Failure, UserModel>> joinOrganization(
      JoinOrganizationPayload payload) async {
    try {
      final res = await api.joinOrganization(payload);
      await authService.updateCacheUser(user: res);
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException().errorMessage));
    }
  }

  @override
  Future<Either<Failure, Organization>> getOrganization(
      String organizationId) async {
    try {
      final res = await api.getOrganization(organizationId: organizationId);
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException().errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getOrganizationMembers(
      String organizationId) async {
    try {
      final res =
          await api.getOrganizationMembers(organizationId: organizationId);
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException().errorMessage));
    }
  }

  @override
  Future<Either<Failure, Organization>> updateOrganization(
      UpdateOrganizationPayload payload) async {
    try {
      final res = await api.updateOrganization(
        organizationId: payload.organizationId,
        npoName: payload.npoName,
        npoEmail: payload.npoEmail,
        npoContactPhoneNumber: payload.npoContactPhoneNumber,
        imageFile: payload.imageFile,
      );
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException().errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<Organization>>> getOrganizations(
      GetOrganizationsPayload payload) async {
    try {
      // return right(Organization.samples);
      final res = await api.getOrganizations(limit: payload.limit ?? 0);
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException().errorMessage));
    }
  }
}
