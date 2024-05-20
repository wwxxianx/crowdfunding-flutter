import 'dart:io';

import 'package:crowdfunding_flutter/data/network/payload/sign_up_payload.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_category.dart';
import 'package:crowdfunding_flutter/domain/model/state/state_region.dart';
import 'package:crowdfunding_flutter/domain/model/tokens_response.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'retrofit_api.g.dart';

@RestApi(baseUrl: 'https://crowdfunding-ngustudio-7cca7759.koyeb.app/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;
  // Constants
  @GET("state-and-regions")
  Future<List<StateAndRegion>> getStateAndRegions();

  @POST("auth/sign-up")
  Future<TokensResponse> signUp(@Body() SignUpPayload signUpDto);

  @POST("auth/sign-in")
  Future<UserModelWithAccessToken> signIn(@Body() String userId);

  // Campaign
  @GET("campaigns")
  Future<List<Campaign>> getCampaigns();

  @POST("campaigns")
  @MultiPart()
  Future<void> createCampaign({
    @Part(name: "title") required String title,
    @Part(name: "description") required String description,
    @Part(name: "targetAmount") required int targetAmount,
    @Part(name: "titcategoryIdle") required String categoryId,
    @Part(name: "contactPhoneNumber") required String phoneNumber,
    @Part(name: "stateId") required String stateId,
    @Part(name: "beneficiaryName") required String beneficiaryName,
    @Part(name: "campaignImages") required List<File> campaignImageFiles,
    @Part(name: "campaignVideo") File? campaignVideoFile,
    @Part(name: "beneficiaryImage") File? beneficiaryImageFile,
  });

  // Campaign categories
  @GET("campaign-categories")
  Future<List<CampaignCategory>> getCampaignCategories();

  // User
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
}
