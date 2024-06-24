import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/community_challenge/create_challenge_participant_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/community_challenge/update_challenge_participant_payload.dart';
import 'package:crowdfunding_flutter/data/network/retrofit_api.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/challenge_participant.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/community_challenge.dart';
import 'package:crowdfunding_flutter/domain/repository/community_challenge/community_challenge_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/src/either.dart';

class CommunityChallengeRepositoryImpl implements CommunityChallengeRepository {
  final RestClient api;

  const CommunityChallengeRepositoryImpl({required this.api});

  @override
  Future<Either<Failure, ChallengeParticipant>> createChallengeParticipant(
      CreateChallengeParticipantPayload payload) async {
    try {
      final res = await api.createChallengeParticipant(payload);
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
  Future<Either<Failure, List<CommunityChallenge>>>
      getCommunityChallenges() async {
    try {
      final res = await api.getCommunityChallenges();
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
  Future<Either<Failure, ChallengeParticipant>> updateChallengeParticipant(
      UpdateChallengeParticipantPayload payload) async {
    try {
      final res = await api.updateChallengeParticipant(
        communityChallengeId: payload.communityChallengeId,
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
  Future<Either<Failure, CommunityChallenge>> getCommunityChallenge(
      String id) async {
    try {
      final res = await api.getCommunityChallenge(
        id: id,
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
  Future<Either<Failure, ChallengeParticipant?>> getChallengeProgress(
      {required String communityChallengeId}) async {
    try {
      final res = await api.getChallengeProgress(
        communityChallengeId: communityChallengeId,
      );
      if (res.response.statusCode == 404) {
        // Challenge not started
        return right(null);
      }
      return right(res.data);
    } on Exception catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException().errorMessage));
    }
  }
}
