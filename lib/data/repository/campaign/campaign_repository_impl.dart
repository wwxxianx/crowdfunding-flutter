import 'dart:convert';

import 'package:crowdfunding_flutter/common/constants/constants.dart';
import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/data/local/shared_preference.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/retrofit_api.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_category.dart';
import 'package:crowdfunding_flutter/domain/repository/campaign/campaign_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/src/either.dart';

class CampaignRepositoryImpl implements CampaignRepository {
  final RestClient api;
  final MySharedPreference sp;

  CampaignRepositoryImpl({
    required this.api,
    required this.sp,
  });

  @override
  Future<Either<Failure, List<Campaign>>> getCampaigns() async {
    try {
      final campaignsRes = await api.getCampaigns();
      return right(campaignsRes);
    } catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException().errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<CampaignCategory>>>
      getCampaignCategories() async {
    try {
      final localData = await sp.getDataIfNotExpired(
        Constants.sharedPreferencesKey.campaignCategories,
        Constants.sharedPreferencesKey.campaignCategoriesExpiration,
      );
      if (localData != null) {
        final data = List<CampaignCategory>.from(
          (jsonDecode(localData) as List).map(
            (category) => CampaignCategory.fromJson(category),
          ),
        );
        if (data.isNotEmpty) {
          return right(data);
        }
      }
      // Failed to get data from cache
      final remoteData = await api.getCampaignCategories();
      if (remoteData.isNotEmpty) {
        sp.saveDataWithExpiration(
          Constants.sharedPreferencesKey.campaignCategories,
          Constants.sharedPreferencesKey.campaignCategoriesExpiration,
          jsonEncode(remoteData),
        );
      }
      return right(remoteData);
    } catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException().errorMessage));
    }
  }
}
