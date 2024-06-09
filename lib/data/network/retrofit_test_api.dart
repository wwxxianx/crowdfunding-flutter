// import 'dart:io';

// import 'package:crowdfunding_flutter/data/network/payload/auth/login_be_payload.dart';
// import 'package:crowdfunding_flutter/data/network/payload/auth/sign_up_payload.dart';
// import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_comment_payload.dart';
// import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_reply_payload.dart';
// import 'package:crowdfunding_flutter/data/network/payload/user/favourite_campaign/favourite_campaign_payload.dart';
// import 'package:crowdfunding_flutter/data/network/retrofit_api.dart';
// import 'package:crowdfunding_flutter/data/service/payment/campaign_donation/create_campaign_donation_payment_intent_payload.dart';
// import 'package:crowdfunding_flutter/data/service/payment/gift_card/create_gift_card_payment_intent_payload.dart';
// import 'package:crowdfunding_flutter/data/service/payment/payment_intent_response.dart';
// import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
// import 'package:crowdfunding_flutter/domain/model/campaign/campaign_category.dart';
// import 'package:crowdfunding_flutter/domain/model/campaign/campaign_comment.dart';
// import 'package:crowdfunding_flutter/domain/model/campaign/campaign_update.dart';
// import 'package:crowdfunding_flutter/domain/model/gift_card/gift_card.dart';
// import 'package:crowdfunding_flutter/domain/model/gift_card/gift_cards_response.dart';
// import 'package:crowdfunding_flutter/domain/model/gift_card/num_gift_card_response.dart';
// import 'package:crowdfunding_flutter/domain/model/state/state_region.dart';
// import 'package:crowdfunding_flutter/domain/model/tokens_response.dart';
// import 'package:crowdfunding_flutter/domain/model/user/user.dart';
// import 'package:crowdfunding_flutter/domain/model/user/user_favourite_campaign.dart';
// import 'package:dio/dio.dart';
// import 'package:retrofit/http.dart';

// class RestClientTesting implements RestClient {
//   @override
//   Future<void> createCampaign(
//       {required String title,
//       required String description,
//       required int targetAmount,
//       required String categoryId,
//       required String phoneNumber,
//       required String stateId,
//       required String beneficiaryName,
//       required List<File> campaignImageFiles,
//       File? campaignVideoFile,
//       File? beneficiaryImageFile}) {
//     // TODO: implement createCampaign
//     throw UnimplementedError();
//   }

//   @override
//   Future<CampaignComment> createCampaignComment(
//       CreateCampaignCommentPayload payload) {
//     // TODO: implement createCampaignComment
//     throw UnimplementedError();
//   }

//   @override
//   Future<PaymentIntentResponse> createCampaignDonationPaymentIntent(
//       CreateCampaignDonationPaymentIntentPayload payload) {
//     // TODO: implement createCampaignDonationPaymentIntent
//     throw UnimplementedError();
//   }

//   @override
//   Future<CampaignComment> createCampaignReply(
//       CreateCampaignReplyPayload payload) {
//     // TODO: implement createCampaignReply
//     throw UnimplementedError();
//   }

//   @override
//   Future<CampaignUpdate> createCampaignUpdates(
//       {required String title,
//       required String description,
//       required String campaignId,
//       required List<File> imageFiles}) {
//     // TODO: implement createCampaignUpdates
//     throw UnimplementedError();
//   }

//   @override
//   Future<PaymentIntentResponse> createGiftCardPaymentIntent(
//       CreateGiftCardPaymentIntentPayload payload) {
//     // TODO: implement createGiftCardPaymentIntent
//     throw UnimplementedError();
//   }

//   @override
//   Future<UserFavouriteCampaign> createUserFavouriteCampaign(
//       FavouriteCampaignPayload payload) {
//     // TODO: implement createUserFavouriteCampaign
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> deleteUserFavouriteCampaign(FavouriteCampaignPayload payload) {
//     // TODO: implement deleteUserFavouriteCampaign
//     throw UnimplementedError();
//   }

//   @override
//   Future<GiftCardsResponse> getAllGiftCards() async {
//     return GiftCardsResponse();
//   }

//   @override
//   Future<Campaign> getCampaign(String campaignId) async {
//     return Campaign.sample;
//   }

//   @override
//   Future<List<CampaignCategory>> getCampaignCategories() async {
//     return CampaignCategory.samples;
//   }

//   @override
//   Future<List<Campaign>> getCampaigns(
//       {String? userId,
//       List<String> categoryIds = const [],
//       List<String> stateIds = const [],
//       String? searchQuery}) async {
//     return Campaign.samples;
//   }

//   @override
//   Future<NumOfGiftCardsResponse> getNumOfReceivedUnusedGiftCards() {
//     // TODO: implement getNumOfReceivedUnusedGiftCards
//     throw UnimplementedError();
//   }

//   @override
//   Future<TokensResponse> getRefreshToken() async {
//     return TokensResponse(
//         accessToken: 'accessToken', refreshToken: 'refreshToken');
//   }

//   @override
//   Future<List<StateAndRegion>> getStateAndRegions() async {
//     return StateAndRegion.samples;
//   }

//   @override
//   Future<List<UserFavouriteCampaign>> getUserFavouriteCampaigns() {
//     // TODO: implement getUserFavouriteCampaigns
//     throw UnimplementedError();
//   }

//   @override
//   Future<UserModel> getUserProfile() {
//     // TODO: implement getUserProfile
//     throw UnimplementedError();
//   }

//   @override
//   Future<List<UserModel>> getUsers({String? userName, String? email}) {
//     // TODO: implement getUsers
//     throw UnimplementedError();
//   }

//   @override
//   Future<UserModelWithAccessToken> signIn(LoginBEPayload payload) {
//     // TODO: implement signIn
//     throw UnimplementedError();
//   }

//   @override
//   Future<TokensResponse> signUp(SignUpPayload signUpPayload) {
//     // TODO: implement signUp
//     throw UnimplementedError();
//   }

//   @override
//   Future<PaymentIntentResponse> testPayment() {
//     // TODO: implement testPayment
//     throw UnimplementedError();
//   }

//   @override
//   Future<Campaign> updateCampaign(
//       {required String campaignId,
//       required String title,
//       required String description,
//       required int targetAmount,
//       required String categoryId,
//       required String phoneNumber,
//       required String stateId,
//       required String beneficiaryName,
//       required List<File> newCampaignImageFiles,
//       File? newCampaignVideoFile,
//       File? newBeneficiaryImageFile,
//       required List<String> oriCampaignImagesId,
//       String? oriBeneficiaryImageUrl}) {
//     // TODO: implement updateCampaign
//     throw UnimplementedError();
//   }

//   @override
//   Future<UserModel> updateUserProfile(
//       {String? fullName,
//       File? profileImageFile,
//       List<String>? favouriteCategoriesId,
//       String phoneNumber = "112901029",
//       bool? isOnboardingCompleted}) {
//     // TODO: implement updateUserProfile
//     throw UnimplementedError();
//   }
// }
