import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/favourite_campaign/favourite_campaign_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/get_users_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/tax_receipt/get_tax_receipt_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/user_profile_payload.dart';
import 'package:crowdfunding_flutter/data/network/response/donation/user_grouped_donations_response.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_donation.dart';
import 'package:crowdfunding_flutter/domain/model/community_challenge/challenge_participant.dart';
import 'package:crowdfunding_flutter/domain/model/gift_card/gift_cards_response.dart';
import 'package:crowdfunding_flutter/domain/model/gift_card/num_gift_card_response.dart';
import 'package:crowdfunding_flutter/domain/model/tax_receipt/tax_receipt.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/model/user/user_favourite_campaign.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UserRepository {
  Future<Either<Failure, UserModel>> updateUserProfile(
    UserProfilePayload payload,
  );

  Future<Either<Failure, UserModel>> getCurrentUser();
  Future<Either<Failure, UserModel>> getCurrentUserProfile();

  Future<Either<Failure, List<UserModel>>> getUsers(GetUsersPayload payload);

  Future<Either<Failure, List<UserFavouriteCampaign>>> getFavouriteCampaigns();

  Future<Either<Failure, UserFavouriteCampaign>> createFavouriteCampaign(
    FavouriteCampaignPayload payload,
  );

  Future<Either<Failure, Unit>> deleteFavouriteCampaign(
    FavouriteCampaignPayload payload,
  );

  Future<Either<Failure, NumOfGiftCardsResponse>>
      getNumOfReceivedUnusedGiftCards();

  Future<Either<Failure, GiftCardsResponse>> getAllGiftCards();

  Future<Either<Failure, List<ChallengeParticipant>>>
      getParticipatedChallenges();

  Future<Either<Failure, List<CampaignDonation>>> getUserDonations();

  Future<Either<Failure, TaxReceipt>>
      getUserTaxReceipt(GetTaxReceiptPayload payload);
}
