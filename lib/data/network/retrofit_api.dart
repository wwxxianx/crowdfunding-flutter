import 'dart:io';

import 'package:crowdfunding_flutter/common/constants/constants.dart';
import 'package:crowdfunding_flutter/data/network/payload/auth/login_be_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/auth/sign_up_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_comment_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_reply_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/favourite_campaign/favourite_campaign_payload.dart';
import 'package:crowdfunding_flutter/data/service/payment/create_payment_intent_payload.dart';
import 'package:crowdfunding_flutter/data/service/payment/payment_intent_response.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_category.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_comment.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_update.dart';
import 'package:crowdfunding_flutter/domain/model/state/state_region.dart';
import 'package:crowdfunding_flutter/domain/model/tokens_response.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/model/user/user_favourite_campaign.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'retrofit_api.g.dart';

@RestApi(baseUrl: Constants.apiUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;
  // Constants
  @GET("state-and-regions")
  Future<List<StateAndRegion>> getStateAndRegions();

  // Auth
  @POST("auth/sign-up")
  Future<TokensResponse> signUp(@Body() SignUpPayload signUpPayload);

  @POST("auth/sign-in")
  Future<UserModelWithAccessToken> signIn(@Body() LoginBEPayload payload);

  @POST("auth/refresh")
  Future<TokensResponse> getRefreshToken();

  // Campaign
  @GET("campaigns")
  Future<List<Campaign>> getCampaigns({
    @Query("userId") String? userId,
    @Query("categoryIds") List<String> categoryIds = const [],
    @Query("stateIds") List<String> stateIds = const [],
    @Query("searchQuery") String? searchQuery,
  });

  @GET("campaigns/{id}")
  Future<Campaign> getCampaign(@Path('id') String campaignId);

  @POST("campaigns")
  @MultiPart()
  Future<void> createCampaign({
    @Part(name: "title") required String title,
    @Part(name: "description") required String description,
    @Part(name: "targetAmount") required int targetAmount,
    @Part(name: "categoryId") required String categoryId,
    @Part(name: "contactPhoneNumber") required String phoneNumber,
    @Part(name: "stateId") required String stateId,
    @Part(name: "beneficiaryName") required String beneficiaryName,
    @Part(name: "campaignImages") required List<File> campaignImageFiles,
    @Part(name: "campaignVideo") File? campaignVideoFile,
    @Part(name: "beneficiaryImage") File? beneficiaryImageFile,
  });

  @PATCH("campaigns/{id}")
  @MultiPart()
  Future<Campaign> updateCampaign({
    @Path("id") required String campaignId,
    @Part(name: "title") required String title,
    @Part(name: "description") required String description,
    @Part(name: "targetAmount") required int targetAmount,
    @Part(name: "categoryId") required String categoryId,
    @Part(name: "contactPhoneNumber") required String phoneNumber,
    @Part(name: "stateId") required String stateId,
    @Part(name: "beneficiaryName") required String beneficiaryName,
    @Part(name: "campaignImages") required List<File> newCampaignImageFiles,
    @Part(name: "campaignVideo") File? newCampaignVideoFile,
    @Part(name: "beneficiaryImage") File? newBeneficiaryImageFile,
    @Part(name: "oriCampaignImagesId")
    required List<String> oriCampaignImagesId,
    @Part(name: "oriBeneficiaryImageUrl") String? oriBeneficiaryImageUrl,
    // @Part(name: "oriCampaignVideo") oriCampaignImages,
  });

  // Campaign comment
  @POST("campaign-comments")
  Future<CampaignComment> createCampaignComment(
    @Body() CreateCampaignCommentPayload payload,
  );

  @POST("campaign-comments/reply")
  Future<CampaignComment> createCampaignReply(
    @Body() CreateCampaignReplyPayload payload,
  );

  // Campaign categories
  @GET("campaign-categories")
  Future<List<CampaignCategory>> getCampaignCategories();

  // Campaign updates
  @POST('campaign-updates')
  @MultiPart()
  Future<CampaignUpdate> createCampaignUpdates({
    @Part(name: "title") required String title,
    @Part(name: "description") required String description,
    @Part(name: "campaignId") required String campaignId,
    @Part(name: "imageFiles") required List<File> imageFiles,
  });

  // User Profile
  @PATCH("users")
  @MultiPart()
  Future<UserModel> updateUserProfile({
    @Part(name: "fullName") String? fullName,
    @Part(name: "profileImageFile") File? profileImageFile,
    @Part(name: "favouriteCategoriesId") List<String>? favouriteCategoriesId,
    @Part(name: "phoneNumber") String phoneNumber = "112901029",
    @Part(name: "isOnboardingCompleted") bool? isOnboardingCompleted,
  });

  @GET("users")
  Future<UserModel> getUserProfile();

  // User favourite campaigns
  @GET("user-favourite-campaigns")
  Future<List<UserFavouriteCampaign>> getUserFavouriteCampaigns();

  @POST("user-favourite-campaigns")
  Future<UserFavouriteCampaign> createUserFavouriteCampaign(
    @Body() FavouriteCampaignPayload payload,
  );

  @DELETE("user-favourite-campaigns")
  Future<void> deleteUserFavouriteCampaign(
    @Body() FavouriteCampaignPayload payload,
  );

  // Payment sheet
  @POST("payment/payment-intent")
  Future<PaymentIntentResponse> createPaymentIntent(
    @Body() CreatePaymentIntentPayload payload,
  );
}
