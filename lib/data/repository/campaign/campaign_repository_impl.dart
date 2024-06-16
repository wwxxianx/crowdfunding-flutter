import 'dart:convert';

import 'package:crowdfunding_flutter/common/constants/constants.dart';
import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/data/local/shared_preference.dart';
import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/campaign_update/create_campaign_update_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_comment_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_reply_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/update_campaign_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/donation/create_campaign_donation_payload.dart';
import 'package:crowdfunding_flutter/data/network/response/donation/giftcard_donation_response.dart';
import 'package:crowdfunding_flutter/data/network/retrofit_api.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_category.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_comment.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_donation.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_update.dart';
import 'package:crowdfunding_flutter/domain/repository/campaign/campaign_repository.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/fetch_campaigns.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:fpdart/src/either.dart';

class CampaignRepositoryImpl implements CampaignRepository {
  final RestClient api;
  final MySharedPreference sp;

  CampaignRepositoryImpl({
    required this.api,
    required this.sp,
  });

  @override
  Future<Either<Failure, List<Campaign>>> getCampaigns(
      FetchCampaignsPayload payload) async {
    try {
      final campaignsRes = await api.getCampaigns(
        userId: payload.userId,
        categoryIds: payload.categoryIds,
        stateIds: payload.stateIds,
        searchQuery: payload.searchQuery,
      );
      return right(campaignsRes);
    } on Exception catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException(error: e).errorMessage));
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

  @override
  Future<Either<Failure, CampaignSummary>> createCampaign(
      CreateCampaignPayload payload) async {
    try {
      final res = await api.createCampaign(
        title: payload.title,
        description: payload.description,
        targetAmount: payload.targetAmount,
        categoryId: payload.categoryId,
        phoneNumber: payload.phoneNumber,
        stateId: payload.stateId,
        beneficiaryName: payload.beneficiaryName,
        campaignImageFiles: payload.campaignImageFiles,
        campaignVideoFile: payload.campaignVideoFile,
        beneficiaryImageFile: payload.beneficiaryImageFile,
      );
      return right(res);
    } catch (e) {
      if (e is DioException) {
        final errorMessage = ErrorHandler.dioException(error: e).errorMessage;
        return left(Failure(errorMessage));
      }
      return left(Failure(ErrorHandler.otherException().errorMessage));
    }
  }

  @override
  Future<Either<Failure, Campaign>> getCampaign(String campaignId) async {
    try {
      final res = await api.getCampaign(campaignId);
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
  Future<Either<Failure, CampaignComment>> createCampaignComment(
      CreateCampaignCommentPayload payload) async {
    try {
      final res = await api.createCampaignComment(payload);
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
  Future<Either<Failure, CampaignComment>> createCampaignReply(
      CreateCampaignReplyPayload payload) async {
    try {
      final res = await api.createCampaignReply(payload);
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
  Future<Either<Failure, Campaign>> updateCampaign(
      UpdateCampaignPayload payload) async {
    try {
      final res = await api.updateCampaign(
        campaignId: payload.campaignId,
        title: payload.title,
        description: payload.description,
        targetAmount: payload.targetAmount,
        categoryId: payload.categoryId,
        phoneNumber: payload.phoneNumber,
        stateId: payload.stateId,
        beneficiaryName: payload.beneficiaryName,
        newCampaignImageFiles: payload.newCampaignImageFiles,
        oriCampaignImagesId: payload.oriCampaignImagesId,
        oriBeneficiaryImageUrl: payload.oriBeneficiaryImageUrl,
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
  Future<Either<Failure, CampaignUpdate>> createCampaignUpdatePost(
      CreateCampaignUpdatePayload payload) async {
    try {
      final res = await api.createCampaignUpdates(
        campaignId: payload.campaignId,
        title: payload.title,
        description: payload.description,
        imageFiles: payload.imageFiles,
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
  Future<Either<Failure, GiftCardDonationResponse>> createGiftCardDonation(CreateGiftCardDonationPayload payload) async {
    try {
      final res = await api.createGiftCardDonation(payload);
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
