import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/collaboration/create_collaboration_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/collaboration/fetch_collaboration_filter.dart';
import 'package:crowdfunding_flutter/data/network/payload/collaboration/update_collaboration_payload.dart';
import 'package:crowdfunding_flutter/data/network/retrofit_api.dart';
import 'package:crowdfunding_flutter/domain/model/collaboration/collaboration.dart';
import 'package:crowdfunding_flutter/domain/repository/collaboration/collaboration_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/src/either.dart';

class CollaborationRepositoryImpl implements CollaborationRepository {
  final RestClient api;

  const CollaborationRepositoryImpl({required this.api});

  @override
  Future<Either<Failure, Collaboration?>> getCollaboration(
      {required String collaborationId}) async {
    try {
      final res = await api.getCollaboration(collaborationId: collaborationId);
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
  Future<Either<Failure, List<Collaboration>>> getCollaborations(
      FetchCollaborationFilter filter) async {
    try {
      final res = await api.getCollaborations(
        isPending: filter.isPending,
        organizationId: filter.organizationId,
        campaignId: filter.campaignId,
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
  Future<Either<Failure, Collaboration>> createCollaboration(
      CreateCollaborationPayload payload) async {
    try {
      final res = await api.createCollaboration(payload);
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
  Future<Either<Failure, Collaboration>> updateCollaboration(
      {required UpdateCollaborationPayload payload}) async {
    try {
      final res = await api.updateCollaboration(
          collaborationId: payload.collaborationId, payload: payload);
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
  Future<Either<Failure, Collaboration>> organizationAcceptCollaboration(
      {required String collaborationId}) async {
    try {
      final res = await api.organizationAcceptCollaboration(
          collaborationId: collaborationId);
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
