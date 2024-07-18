import 'dart:io';

import 'package:crowdfunding_flutter/common/constants/constants.dart';
import 'package:crowdfunding_flutter/data/network/payload/auth/login_be_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/auth/sign_up_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_comment_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_reply_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/collaboration/create_collaboration_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/collaboration/update_collaboration_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/community_challenge/create_challenge_participant_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/donation/create_campaign_donation_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/organization/join_organization_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/stripe/update_connect_account_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/favourite_campaign/favourite_campaign_payload.dart';
import 'package:crowdfunding_flutter/data/network/response/donation/giftcard_donation_response.dart';
import 'package:crowdfunding_flutter/data/network/response/payment/connect_account_response.dart';
import 'package:crowdfunding_flutter/data/service/payment/campaign_donation/create_campaign_donation_payment_intent_payload.dart';
import 'package:crowdfunding_flutter/data/service/payment/gift_card/create_gift_card_payment_intent_payload.dart';
import 'package:crowdfunding_flutter/data/service/payment/payment_intent_response.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_category.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_comment.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_donation.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_fundraiser.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_update.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/enum/campaign_enum.dart';
import 'package:crowdfunding_flutter/domain/model/collaboration/collaboration.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/challenge_participant.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/community_challenge.dart';
import 'package:crowdfunding_flutter/domain/model/gift_card/gift_cards_response.dart';
import 'package:crowdfunding_flutter/domain/model/gift_card/num_gift_card_response.dart';
import 'package:crowdfunding_flutter/domain/model/notification/notification.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/domain/model/scam_report/scam_report.dart';
import 'package:crowdfunding_flutter/domain/model/state/state_region.dart';
import 'package:crowdfunding_flutter/domain/model/stripe/stripe_account.dart';
import 'package:crowdfunding_flutter/domain/model/tax_receipt/tax_receipt.dart';
import 'package:crowdfunding_flutter/domain/model/tokens_response.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/model/user/user_favourite_campaign.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

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
    @Query("isPublished") bool? isPublished,
    @Query("identification") IdentificationStatusEnum? identificationStatus,
  });

  @GET("campaigns/successful")
  Future<List<Campaign>> getSuccessfulCampaigns();

  @GET("campaigns/{id}")
  Future<Campaign> getCampaign(@Path('id') String campaignId);

  @GET("campaigns/{id}/fundraiser")
  Future<CampaignFundraiser> getCampaignFundraiser(
      @Path('id') String campaignId);

  @PATCH("campaigns/{id}/fundraiser")
  Future<CampaignFundraiser> updateCampaignFundraiser({
    @Path('id') required String campaignId,
    @Part(name: "fundraiserIdentityNumber") String? idNumber,
    @Part(name: "signatureFile") File? signatureFile,
  });

  @POST("campaigns")
  @MultiPart()
  Future<CampaignSummary> createCampaign({
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
    @Part(name: "expiredAt") required String expiredAt,
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

  @GET("users/profile")
  Future<UserModel> getUserProfile();

  @GET("users")
  Future<List<UserModel>> getUsers({
    @Query("userName") String? userName,
    @Query("email") String? email,
  });

  @GET("users/donations")
  Future<List<CampaignDonation>> getUserDonations();

  @GET("users/tax-receipts")
  Future<TaxReceipt> getUserTaxReceipt({@Query('year') int? year});

  // Users gift card
  @GET("users/received-gift-card-num")
  Future<NumOfGiftCardsResponse> getNumOfReceivedUnusedGiftCards();

  @GET("users/gift-cards")
  Future<GiftCardsResponse> getAllGiftCards();

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

  // Donations
  @POST("donations")
  Future<GiftCardDonationResponse> createGiftCardDonation(
    @Body() CreateGiftCardDonationPayload payload,
  );

  // Payment
  @POST("payment/payment-intent/campaign-donation")
  Future<PaymentIntentResponse> createCampaignDonationPaymentIntent(
    @Body() CreateCampaignDonationPaymentIntentPayload payload,
  );

  @POST("payment/payment-intent/gift-card")
  Future<PaymentIntentResponse> createGiftCardPaymentIntent(
    @Body() CreateGiftCardPaymentIntentPayload payload,
  );

  @POST("payment/test-payment")
  Future<PaymentIntentResponse> testPayment();

  @POST("payment/connect-account")
  Future<ConnectAccountResponse> connectStripeAccount();

  @POST("payment/onboard-update")
  Future<ConnectAccountResponse> updateConnectAccount(
      @Body() UpdateConnectAccountPayload payload);

  @GET("payment/connected-account/{id}")
  Future<StripeAccount> getConnectedAccount({
    @Path('id') required String connectedAccountId,
  });

  // Organization
  @GET("organizations")
  Future<List<Organization>> getOrganizations({
    @Query("limit") int limit = 0,
  });

  @POST("organizations")
  @MultiPart()
  Future<UserModel> createOrganization({
    @Part(name: "name") required String npoName,
    @Part(name: "email") required String npoEmail,
    // @Part(name: "registrationNumber") required String registrationNumber,
    @Part(name: "contactPhoneNumber") required String npoContactPhoneNumber,
    @Part(name: "imageFile") File? imageFile,
  });

  @PATCH("organizations/{id}")
  @MultiPart()
  Future<Organization> updateOrganization({
    @Path('id') required String organizationId,
    @Part(name: "name") required String npoName,
    @Part(name: "email") required String npoEmail,
    @Part(name: "contactPhoneNumber") required String npoContactPhoneNumber,
    @Part(name: "imageFile") File? imageFile,
  });

  @GET("organizations/{id}")
  Future<Organization> getOrganization({
    @Path('id') required String organizationId,
  });

  @GET("organizations/{id}/members")
  Future<List<UserModel>> getOrganizationMembers({
    @Path('id') required String organizationId,
  });

  @GET("organizations/invitation/{code}")
  Future<Organization> getOrganizationByInvitationCode({
    @Path('code') required String invitationCode,
  });

  @POST("organizations/join")
  Future<UserModel> joinOrganization(@Body() JoinOrganizationPayload payload);

  // Notifications
  @GET("notifications")
  Future<List<NotificationModel>> getNotifications();

  @PATCH("notifications/{id}")
  Future<NotificationModel> readNotification(
      {@Path('id') required String notificationId});

  // Collaboration
  @POST("collaborations")
  Future<Collaboration> createCollaboration(
    @Body() CreateCollaborationPayload payload,
  );

  @GET("collaborations/{id}")
  Future<Collaboration?> getCollaboration({
    @Path('id') required String campaignId,
  });

  @GET("collaborations")
  Future<List<Collaboration>> getCollaborations(
      {@Query("isPending") bool? isPending});

  @PATCH("collaborations/{id}")
  Future<Collaboration> updateCollaboration({
    @Path('id') required String collaborationId,
    @Body() required UpdateCollaborationPayload payload,
  });

  @PATCH("collaborations/{id}/accept")
  Future<Collaboration> organizationAcceptCollaboration({
    @Path('id') required String collaborationId,
  });

  // Community Challenge
  @GET("community-challenges?isExpired=false")
  Future<List<CommunityChallenge>> getCommunityChallenges();

  @GET("community-challenges/{id}")
  Future<CommunityChallenge> getCommunityChallenge({
    @Path('id') required String id,
  });

  @GET("community-challenges/participants/{communityChallengeId}")
  Future<HttpResponse<ChallengeParticipant>> getChallengeProgress({
    @Path('communityChallengeId') required String communityChallengeId,
  });

  @POST("community-challenges/participants")
  Future<ChallengeParticipant> createChallengeParticipant(
    @Body() CreateChallengeParticipantPayload payload,
  );

  @PATCH("community-challenges/participants")
  @MultiPart()
  Future<ChallengeParticipant> updateChallengeParticipant({
    @Part(name: 'imageFile') File? imageFile,
    @Part(name: 'communityChallengeId') required String communityChallengeId,
  });

  @GET('users/community-challenges')
  Future<List<ChallengeParticipant>> getParticipatedChallenges();

  // Scam Report
  @POST("scam-reports")
  @MultiPart()
  Future<ScamReport> createScamReport({
    @Part(name: 'evidenceImageFiles') List<File>? evidenceImageFiles,
    @Part(name: 'documentFiles') List<File>? documentFiles,
    @Part(name: 'campaignId') required String campaignId,
    @Part(name: 'description') required String description,
  });
}
