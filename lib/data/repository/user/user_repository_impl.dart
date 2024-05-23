import 'dart:convert';

import 'package:crowdfunding_flutter/common/constants/constants.dart';
import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/data/local/shared_preference.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/favourite_campaign/favourite_campaign_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/user_profile_payload.dart';
import 'package:crowdfunding_flutter/data/network/retrofit_api.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/model/user/user_favourite_campaign.dart';
import 'package:crowdfunding_flutter/domain/repository/user/user_repository.dart';
import 'package:crowdfunding_flutter/domain/service/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/src/either.dart';
import 'package:fpdart/src/unit.dart';
import 'package:logger/logger.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient api;
  final MySharedPreference sp;
  final AuthService authService;

  UserRepositoryImpl({
    required this.api,
    required this.sp,
    required this.authService,
  });

  @override
  Future<Either<Failure, UserModel>> updateUserProfile(
      UserProfilePayload payload) async {
    var logger = Logger();
    try {
      final res = await api.updateUserProfile(
        favouriteCategoriesId: payload.favouriteCategoriesId,
        fullName: payload.fullName,
        isOnboardingCompleted: payload.isOnBoardingCompleted,
        profileImageFile: payload.profileImageFile,
        phoneNumber: "11209129",
      );
      // Cache user
      sp.saveData(
          data: jsonEncode(res), key: Constants.sharedPreferencesKey.user);
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException(error: e).errorMessage));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserProfile() async {
    final user = await authService.getCurrentUser();
    if (user == null) {
      return left(Failure());
    }
    return right(user);
  }

  @override
  Future<Either<Failure, UserFavouriteCampaign>> createFavouriteCampaign(
      FavouriteCampaignPayload payload) async {
    try {
      final res = await api.createUserFavouriteCampaign(payload);
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException(error: e).errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<UserFavouriteCampaign>>> getFavouriteCampaigns() async {
    try {
      final res = await api.getUserFavouriteCampaigns();
      return right(res);
    } on Exception catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException(error: e).errorMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteFavouriteCampaign(
      FavouriteCampaignPayload payload) async {
    try {
      await api.deleteUserFavouriteCampaign(payload);
      return right(unit);
    } on DioException catch (e) {
      final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
      return left(Failure(errorMessage));
    } on Exception catch (e) {
      return left(Failure(ErrorHandler.otherException(error: e).errorMessage));
    }
  }
}
